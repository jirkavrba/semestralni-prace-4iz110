# frozen_string_literal: true

module Indexing
  class Indexer
    def index_page(url, page, domain)
      text = Nokogiri::HTML(page.body).text
      domain.indexed_pages.create url: url,
                                  body: text,
                                  title: page.title
    end

    def remove_domain(domain)
      IndexedPage.where(domain_id: domain.id).delete_all
    end
  end
end
