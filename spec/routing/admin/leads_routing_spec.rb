require "rails_helper"

RSpec.describe Admin::LeadsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/admin/leads").to route_to("admin/leads#index")
    end

    it "routes to #new" do
      expect(get: "/admin/leads/new").to route_to("admin/leads#new")
    end

    it "routes to #show" do
      expect(get: "/admin/leads/1").to route_to("admin/leads#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/admin/leads/1/edit").to route_to("admin/leads#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/admin/leads").to route_to("admin/leads#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/admin/leads/1").to route_to("admin/leads#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/admin/leads/1").to route_to("admin/leads#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/admin/leads/1").to route_to("admin/leads#destroy", id: "1")
    end
  end
end
