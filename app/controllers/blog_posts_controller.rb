class BlogPostsController < ApplicationController
  def index
    @page = PageSetting.for("blog")
    apply_page_meta_tags("blog", fallback_title: "Blog & Travel Insights")
    scope = BlogPost.published.includes(:blog_category, :author).recent
    scope = scope.where(blog_category_id: params[:category]) if params[:category].present?
    if params[:q].present?
      pattern = "%#{ActiveRecord::Base.sanitize_sql_like(params[:q].strip)}%"
      scope = scope.where("title ILIKE ? OR excerpt ILIKE ? OR tags ILIKE ?", pattern, pattern, pattern)
    end
    @pagy, @blog_posts = pagy(:offset, scope, limit: 9)
    @categories = BlogCategory.order(:name)
  end

  def show
    @blog_post = BlogPost.friendly.find(params[:slug])
    set_meta_tags(
      title: @blog_post.meta_title.presence || @blog_post.title,
      description: @blog_post.meta_description.presence || @blog_post.excerpt
    )
    @related_posts = BlogPost.published
                             .where(blog_category_id: @blog_post.blog_category_id)
                             .where.not(id: @blog_post.id)
                             .recent.limit(3)
  end
end
