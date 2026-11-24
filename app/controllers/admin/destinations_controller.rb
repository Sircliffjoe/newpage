class Admin::DestinationsController < Admin::BaseController
  before_action :require_content_editor!
  before_action :set_destination, only: [ :show, :edit, :update, :destroy ]

  def index
    @destinations = Destination.ordered
  end

  def show; end

  def new
    @destination = Destination.new(published: true, visa_required: true)
  end

  def edit; end

  def create
    @destination = Destination.new(destination_params)
    if @destination.save
      redirect_to admin_destinations_path, notice: "Destination created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @destination.update(destination_params)
      redirect_to admin_destinations_path, notice: "Destination updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @destination.destroy
    redirect_to admin_destinations_path, notice: "Destination deleted.", status: :see_other
  end

  private

  def set_destination
    @destination = Destination.friendly.find(params[:id])
  end

  def destination_params
    params.require(:destination).permit(
      :name, :slug, :country_code, :category, :short_description, :description,
      :hero_image, :requirements, :cost_estimate, :visa_required, :position, :published, :featured
    )
  end
end
