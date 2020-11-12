class SearchController < ApplicationController
  def index
    @indexed_domains = Domain.where(status: :indexed).count
  end

  def results
    @query = params[:query]
    @results = IndexedPage.search(params[:query])
                          .page(params[:page])
                          .per(5)
  end
end
