class IndexDomainJob < ApplicationJob
  queue_as :default

  def perform(domain)
    domain.update status: :being_indexed

    crawler = Indexing::Crawler.new domain.url
    crawler.run do |page|
      p page.title
    end

    domain.update status: :indexed
  rescue StandardError => e
    # TODO: Better handling of invalid domains
    domain.update status: :error
  end
end
