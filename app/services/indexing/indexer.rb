# frozen_string_literal: true

module Indexing
  class Indexer
    def index_page(url, page, domain, referrer)
      text = Nokogiri::HTML(page.body).text
      domain.indexed_pages.create url: url,
                                  body: text,
                                  title: page.title,
                                  referrer: referrer
    end

    def remove_domain(domain)
      domain.indexed_pages.destroy_all
    end
  end
end
