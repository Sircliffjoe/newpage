class Admin::ServicesController < Admin::BaseController
  before_action :require_content_editor!
  before_action :set_service, only: [:show, :edit, :update, :destroy]

  def index
    @services = Service.ordered
  end

  def show; end

  def new
    @service = Service.new(published: true)
  end

  def edit; end

  def create
    @service = Service.new(service_params)
    if @service.save
      redirect_to admin_services_path, notice: "Service created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @service.update(service_params)
      redirect_to admin_services_path, notice: "Service updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @service.destroy
    redirect_to admin_services_path, notice: "Service deleted.", status: :see_other
  end

  private

  def set_service
    @service = Service.friendly.find(params[:id])
  end

  def service_params
    params.require(:service).permit(
      :title, :slug, :category, :short_description, :description,
      :hero_image, :icon, :benefits, :requirements, :position, :published, :featured
    )
  end
end
