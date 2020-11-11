class IndexDomainJob < ApplicationJob
  queue_as :default

  def perform(domain)
    domain.update status: :being_indexed

    indexer = Indexing::Indexer.new
    indexer.remove_domain domain

    crawler = Indexing::Crawler.new domain.url
    crawler.run do |page, url|
      indexer.index_page(url, page, domain)

      ActionCable.server.broadcast 'crawler', id: domain.id,
                                              title: url,
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
