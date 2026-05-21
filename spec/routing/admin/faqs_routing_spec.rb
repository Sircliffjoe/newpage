require "rails_helper"

RSpec.describe Admin::FaqsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/admin/faqs").to route_to("admin/faqs#index")
    end

    it "routes to #new" do
      expect(get: "/admin/faqs/new").to route_to("admin/faqs#new")
    end

    it "routes to #show" do
      expect(get: "/admin/faqs/1").to route_to("admin/faqs#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/admin/faqs/1/edit").to route_to("admin/faqs#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/admin/faqs").to route_to("admin/faqs#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/admin/faqs/1").to route_to("admin/faqs#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/admin/faqs/1").to route_to("admin/faqs#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/admin/faqs/1").to route_to("admin/faqs#destroy", id: "1")
    end
  end
end
