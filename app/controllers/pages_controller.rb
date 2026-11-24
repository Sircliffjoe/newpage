class PagesController < ApplicationController
  def home
    @page = PageSetting.for("home")
    apply_page_meta_tags("home")
    @services = Service.published.ordered.limit(6)
    @testimonials = Testimonial.published.ordered.limit(3)
    @destinations = Destination.published.ordered.limit(6)
    @recent_posts = BlogPost.published.includes(:blog_category, :author).recent.limit(3)
    @gallery_preview = GalleryImage.published.ordered.limit(6)
  end

  def about
    @page = PageSetting.for("about")
    apply_page_meta_tags("about", fallback_title: "About Us")
    @team_members = TeamMember.published.ordered
  end

  def visa_information
    @page = PageSetting.for("visa_information")
    apply_page_meta_tags("visa_information", fallback_title: "Visa Assistance & Immigration Consulting")
    @visa_services = Service.published.where(category: :visa).ordered
    @visa_faqs = Faq.published.where(category: :visas).ordered.limit(6)
  end

  def study_abroad
    @page = PageSetting.for("study_abroad")
    apply_page_meta_tags("study_abroad", fallback_title: "Study Abroad & Foreign Admissions")
    @study_destinations = Destination.published.where(category: :study).ordered
    @study_services = Service.published.where(category: :study_abroad).ordered
    @study_faqs = Faq.published.where(category: :study_abroad).ordered.limit(6)
  end

  def cac_services
    @page = PageSetting.for("cac_services")
    apply_page_meta_tags("cac_services", fallback_title: "CAC & Corporate Business Registration")
    @cac_services = Service.published.where(category: :cac).ordered
    @cac_faqs = Faq.published.where(category: :cac).ordered.limit(6)
  end

  def privacy_policy
    @page = PageSetting.for("privacy_policy")
    apply_page_meta_tags("privacy_policy", fallback_title: "Privacy Policy")
  end

  def terms_of_service
    @page = PageSetting.for("terms_of_service")
    apply_page_meta_tags("terms_of_service", fallback_title: "Terms of Service")
  end
end
