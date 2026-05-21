class Admin::DestinationsController < Admin::BaseController
  before_action :set_destination, only: [:show, :edit, :update, :destroy]

  def index
    @destinations = Destination.order(position: :asc)
  end

  def show; end
  def new
    @destination = Destination.new
  end
  def edit; end

  def create
    @destination = Destination.new(destination_params)
    if @destination.save
      redirect_to admin_destinations_path, notice: "Destination created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @destination.update(destination_params)
      redirect_to admin_destinations_path, notice: "Destination updated."
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
    @destination = Destination.find(params[:id])
  end

  def destination_params
    params.require(:destination).permit(:name, :country_code, :category, :description, :hero_image, :requirements, :cost_estimate, :position, :published)
  end
end
