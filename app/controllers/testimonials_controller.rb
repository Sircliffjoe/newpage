class TestimonialsController < ApplicationController
  def index
    @testimonials = Testimonial.where(published: true).order(position: :asc)
  end
end
