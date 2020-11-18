class IndexDomainJob < ApplicationJob
  queue_as :default

  def perform(domain)
    domain.update status: :being_indexed

    indexer = Indexing::Indexer.new
    indexer.remove_domain domain

    crawler = Indexing::Crawler.new domain.url
    crawler.run do |page, url, referrer|
      indexer.index_page url, page, domain, referrer

      ActionCable.server.broadcast 'crawler', id: domain.id,
                                              title: url,
                                              type: 'page_indexed'
    end

    domain.update status: :indexed
  rescue StandardError => error
    domain.update status: :error
    Rails.logger.debug error.full_message
  ensure
    ActionCable.server.broadcast 'crawler', id: domain.id, type: 'finished'
  end
end
