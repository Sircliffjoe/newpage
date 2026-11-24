class GalleryController < ApplicationController
  def index
    @page = PageSetting.for("gallery")
    apply_page_meta_tags("gallery", fallback_title: "Photo Gallery")
    @gallery_images = GalleryImage.published.ordered
    if params[:category].present? && GalleryImage.categories.key?(params[:category].to_s)
      @gallery_images = @gallery_images.where(category: params[:category])
    end
    @categories = GalleryImage.categories.keys
  end
end
