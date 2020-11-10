class SearchController < ApplicationController
  def index
    @indexed_domains = Domain.count
  end
end
