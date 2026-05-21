require "rails_helper"

RSpec.describe Admin::DestinationsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/admin/destinations").to route_to("admin/destinations#index")
    end

    it "routes to #new" do
      expect(get: "/admin/destinations/new").to route_to("admin/destinations#new")
    end

    it "routes to #show" do
      expect(get: "/admin/destinations/1").to route_to("admin/destinations#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/admin/destinations/1/edit").to route_to("admin/destinations#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/admin/destinations").to route_to("admin/destinations#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/admin/destinations/1").to route_to("admin/destinations#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/admin/destinations/1").to route_to("admin/destinations#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/admin/destinations/1").to route_to("admin/destinations#destroy", id: "1")
    end
  end
end
