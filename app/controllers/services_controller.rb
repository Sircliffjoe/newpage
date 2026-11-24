class ServicesController < ApplicationController
  def index
    @page = PageSetting.for("services")
    apply_page_meta_tags("services", fallback_title: "Our Services")

    @total_count = Service.published.count
    @category_counts = Service.published.group(:category).count
    @active_category = params[:category].presence if Service.categories.key?(params[:category].to_s)
    @services = @active_category ? Service.published.where(category: @active_category).ordered : Service.published.ordered
  end

  def show
    @service = Service.published.friendly.find(params[:slug])
    set_meta_tags(
      title: @service.title,
      description: @service.short_description.presence || ActionController::Base.helpers.strip_tags(@service.description.to_s).truncate(160)
    )
    @related_services = Service.published.where(category: @service.category)
                               .where.not(id: @service.id).ordered.limit(3)
    faq_category = { "travel" => :travel, "visa" => :visas, "study_abroad" => :study_abroad, "cac" => :cac }[@service.category]
    @faqs = faq_category ? Faq.published.where(category: faq_category).ordered.limit(4) : Faq.none
  end
end
