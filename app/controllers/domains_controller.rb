class DomainsController < ApplicationController
  def index
    @domains = Domain.all
    @indexed, @not_indexed = @domains.partition(&:indexed?)
  end

  def new
    # Just render the template, nothing special to be seen here...
  end

  def create
    @domain = Domain.create create_params
    redirect_to domains_path
  end

  def show
    @domain = Domain.find params[:id]
  end

  def start_indexing
    @domain = Domain.find params[:id]
    @domain.update last_indexed_at: DateTime.now

    IndexDomainJob.perform_later @domain.url
  end

  private

  def create_params
    params.require(:domain).permit(:url)
  end
end
