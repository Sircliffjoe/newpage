class DestinationsController < ApplicationController
  def index
    @page = PageSetting.for("destinations")
    apply_page_meta_tags("destinations", fallback_title: "Travel & Study Destinations")
    @destinations = Destination.published.ordered
    if params[:category].present? && Destination.categories.key?(params[:category].to_s)
      @destinations = @destinations.where(category: params[:category])
    end
  end

  def show
    @destination = Destination.published.friendly.find(params[:slug])
    set_meta_tags(
      title: @destination.name,
      description: @destination.short_description.presence || "Explore #{@destination.name} travel, visa, and study abroad opportunities with NewPage Integrity."
    )
  end
end
