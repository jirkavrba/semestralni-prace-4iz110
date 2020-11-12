module Indexing
  class Indexer
    def index_page(url, page, domain)
      domain.indexed_pages.create url: url,
                                  title: page.title
    end

    def remove_domain(domain)
      IndexedPage.where(domain_id: domain.id).delete_all
    end
  end
end