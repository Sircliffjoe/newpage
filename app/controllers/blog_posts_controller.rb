class BlogPostsController < ApplicationController
  include Pagy::Backend

  def index
    scope = BlogPost.published.includes(:blog_category, :author).order(published_at: :desc)
    scope = scope.where(blog_category_id: params[:category]) if params[:category].present?
    @pagy, @blog_posts = pagy(scope, limit: 9)
    @categories = BlogCategory.all
  end

  def show
    @blog_post = BlogPost.friendly.find(params[:slug])
    @related_posts = BlogPost.published
                             .where(blog_category_id: @blog_post.blog_category_id)
                             .where.not(id: @blog_post.id)
                             .order(published_at: :desc).limit(3)
  end
end
