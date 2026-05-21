class ServicesController < ApplicationController
  def index
    @services = Service.where(published: true).order(position: :asc)
    @services = @services.where(category: params[:category]) if params[:category].present?
  end

  def show
    @service = Service.friendly.find(params[:slug])
    @related_services = Service.where(category: @service.category, published: true)
                               .where.not(id: @service.id).limit(3)
  end
end
