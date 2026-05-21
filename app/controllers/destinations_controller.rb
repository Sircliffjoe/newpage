class DestinationsController < ApplicationController
  def index
    @destinations = Destination.where(published: true).order(position: :asc)
    @destinations = @destinations.where(category: params[:category]) if params[:category].present?
  end

  def show
    @destination = Destination.friendly.find(params[:slug])
  end
end
