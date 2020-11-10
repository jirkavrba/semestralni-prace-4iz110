class DomainsController < ApplicationController
  def index
    @domains = Domain.all
    @indexed, @not_indexed = @domains.partition { |domain| domain.last_indexed_at.nil? }
  end
end
