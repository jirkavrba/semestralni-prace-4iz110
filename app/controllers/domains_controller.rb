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

  def start_indexing
    @domain = Domain.find params[:id]
    @domain.update status: :enqueued,
                   last_indexed_at: DateTime.now

    IndexDomainJob.perform_later @domain

    redirect_to domains_path
  end

  private

  def create_params
    params.require(:domain).permit(:url)
  end
end
