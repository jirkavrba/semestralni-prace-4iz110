class SearchController < ApplicationController
  def index
    @indexed_domains = Domain.where(status: :indexed).count
  end

  def results
  end
end
