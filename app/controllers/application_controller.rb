class ApplicationController < ActionController::Base
  include Pagy::Method
  include Pundit::Authorization

  allow_browser versions: :modern
  stale_when_importmap_changes

  before_action :set_default_meta_tags

  rescue_from Pundit::NotAuthorizedError do
    redirect_to admin_root_path, alert: "You are not authorized to perform this action."
  end

  private

  def set_default_meta_tags
    set_meta_tags(
      site: "NewPage Integrity Travels & Tours",
      title: "Travel, Visa Assistance, Study Abroad & CAC Registration in Nigeria",
      reverse: true,
      separator: "|",
      description: "Trusted travel & tours agency in Warri, Delta State offering visa assistance, study abroad admissions (UK, Canada, USA, Australia, Europe), flight ticketing, and CAC registration.",
      keywords: "travel agency in Warri, visa assistance Nigeria, study abroad Nigeria, Canada admission consultant, UK student visa, CAC registration Warri, flight booking Delta State",
      og: {
        site_name: "NewPage Integrity Travels & Tours",
        type: "website",
        url: request.original_url
      }
    )
  end

  def apply_page_meta_tags(page_key, fallback_title: nil, fallback_description: nil)
    setting = PageSetting.for(page_key)
    title = setting&.meta_title.presence || fallback_title
    description = setting&.meta_description.presence || fallback_description
    og_image = setting&.og_image&.attached? ? url_for(setting.og_image) : (setting&.hero_image&.attached? ? url_for(setting.hero_image) : nil)

    tags = {}
    tags[:title] = title if title.present?
    tags[:description] = description if description.present?
    tags[:og] = { title: title, description: description, image: og_image }.compact if title || description || og_image
    set_meta_tags(tags) if tags.any?
  end
end
