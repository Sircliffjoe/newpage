require 'rails_helper'

RSpec.describe "BlogPosts", type: :request do
  describe "GET /blog" do
    it "returns http success" do
      get blog_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /blog/:slug" do
    it "returns http success" do
      author = User.create!(
        email: "author@newpageintegrity.com",
        password: "password123",
        password_confirmation: "password123",
        first_name: "Content",
        last_name: "Author",
        role: :content_editor
      )
      category = BlogCategory.create!(name: "Travel Tips")
      post_record = BlogPost.create!(
        title: "Packing Guide",
        blog_category: category,
        author: author,
        status: :published,
        excerpt: "Essential packing checklist"
      )

      get blog_post_path(slug: post_record.slug)
      expect(response).to have_http_status(:success)
    end
  end
end
