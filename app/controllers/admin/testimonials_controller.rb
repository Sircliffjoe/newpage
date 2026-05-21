class Admin::TestimonialsController < Admin::BaseController
  before_action :set_testimonial, only: [:edit, :update, :destroy]

  def index
    @testimonials = Testimonial.order(position: :asc)
  end

  def new
    @testimonial = Testimonial.new
  end
  def edit; end

  def create
    @testimonial = Testimonial.new(testimonial_params)
    if @testimonial.save
      redirect_to admin_testimonials_path, notice: "Testimonial created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @testimonial.update(testimonial_params)
      redirect_to admin_testimonials_path, notice: "Testimonial updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @testimonial.destroy
    redirect_to admin_testimonials_path, notice: "Testimonial deleted.", status: :see_other
  end

  private

  def set_testimonial
    @testimonial = Testimonial.find(params[:id])
  end

  def testimonial_params
    params.require(:testimonial).permit(:client_name, :content, :service_received, :rating, :image, :position, :published)
  end
end
