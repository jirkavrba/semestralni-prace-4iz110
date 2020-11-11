class IndexDomainJob < ApplicationJob
  queue_as :default

  def perform(domain)
    domain.update status: :being_indexed

    crawler = Indexing::Crawler.new domain.url
    crawler.run do |page|
      p page.title

      ActionCable.server.broadcast 'crawler', id: domain.id,
                                              title: page.title,
                                              type: 'page_indexed'
    end

    domain.update status: :indexed
  rescue StandardError => e
    # TODO: Better handling of invalid domains
    p e
    domain.update status: :error
  ensure
    ActionCable.server.broadcast 'crawler', id: domain.id, type: 'finished'
  end
end
