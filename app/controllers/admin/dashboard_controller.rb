class Admin::DashboardController < Admin::BaseController
  def index
    @stats = {
      total_leads: Lead.count,
      new_leads: Lead.where(status: :new_lead).count,
      services: Service.count,
      destinations: Destination.count,
      blog_posts: BlogPost.count,
      gallery_images: GalleryImage.count,
      subscribers: NewsletterSubscriber.active.count,
      emails_sent: Email.sent.count
    }

    @recent_leads = Lead.order(created_at: :desc).limit(6)
    @recent_contacts = ContactSubmission.order(created_at: :desc).limit(5)
    @recent_posts = BlogPost.includes(:blog_category).order(created_at: :desc).limit(4)
  end
end
