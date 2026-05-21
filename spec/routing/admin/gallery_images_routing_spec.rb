require "rails_helper"

RSpec.describe Admin::GalleryImagesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/admin/gallery_images").to route_to("admin/gallery_images#index")
    end

    it "routes to #new" do
      expect(get: "/admin/gallery_images/new").to route_to("admin/gallery_images#new")
    end

    it "routes to #show" do
      expect(get: "/admin/gallery_images/1").to route_to("admin/gallery_images#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/admin/gallery_images/1/edit").to route_to("admin/gallery_images#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/admin/gallery_images").to route_to("admin/gallery_images#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/admin/gallery_images/1").to route_to("admin/gallery_images#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/admin/gallery_images/1").to route_to("admin/gallery_images#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/admin/gallery_images/1").to route_to("admin/gallery_images#destroy", id: "1")
    end
  end
end
