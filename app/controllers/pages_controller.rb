class PagesController < ApplicationController
  def home
    @services = Service.where(published: true).order(position: :asc).limit(4)
    @testimonials = Testimonial.where(published: true).order(position: :asc).limit(3)
    @destinations = Destination.where(published: true).order(position: :asc).limit(6)
  end

  def about
    @team_members = TeamMember.where(published: true).order(position: :asc)
  end

  def visa_information; end
  def study_abroad; end
  def cac_services; end
end
