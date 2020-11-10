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

  private

  def create_params
    params.require(:domain).permit(:url)
  end
end
