class GalleryController < ApplicationController
  def index
    @gallery_images = GalleryImage.where(published: true).order(position: :asc)
    @categories = @gallery_images.distinct.pluck(:category)
  end
end
