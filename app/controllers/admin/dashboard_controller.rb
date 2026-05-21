class Admin::DashboardController < Admin::BaseController
  def index
    @total_leads = Lead.count
    @new_leads = Lead.where(status: :new_lead).count
    @total_services = Service.count
    @total_blog_posts = BlogPost.count
    @total_testimonials = Testimonial.count
    @recent_leads = Lead.order(created_at: :desc).limit(5)
    @recent_contacts = ContactSubmission.order(created_at: :desc).limit(5)
  end
end
