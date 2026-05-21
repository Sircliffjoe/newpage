require "rails_helper"

RSpec.describe Admin::BlogPostsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/admin/blog_posts").to route_to("admin/blog_posts#index")
    end

    it "routes to #new" do
      expect(get: "/admin/blog_posts/new").to route_to("admin/blog_posts#new")
    end

    it "routes to #show" do
      expect(get: "/admin/blog_posts/1").to route_to("admin/blog_posts#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/admin/blog_posts/1/edit").to route_to("admin/blog_posts#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/admin/blog_posts").to route_to("admin/blog_posts#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/admin/blog_posts/1").to route_to("admin/blog_posts#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/admin/blog_posts/1").to route_to("admin/blog_posts#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/admin/blog_posts/1").to route_to("admin/blog_posts#destroy", id: "1")
    end
  end
end
