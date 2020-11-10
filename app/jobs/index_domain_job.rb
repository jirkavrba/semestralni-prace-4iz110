class IndexDomainJob < ApplicationJob
  queue_as :default

  def perform(domain)
    crawler = Indexing::Crawler.new domain
    crawler.run do |page|
      p page.title
    end
  end
end
