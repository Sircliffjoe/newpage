class SearchController < ApplicationController
  def index
    @query = params[:q].to_s.strip
    apply_page_meta_tags("search", fallback_title: @query.present? ? "Search: #{@query}" : "Search")

    if @query.present?
      pattern = "%#{ActiveRecord::Base.sanitize_sql_like(@query)}%"
      @services = Service.published.where("title ILIKE ? OR short_description ILIKE ? OR benefits ILIKE ?", pattern, pattern, pattern).ordered.limit(12)
      @destinations = Destination.published.where("name ILIKE ? OR short_description ILIKE ? OR requirements ILIKE ?", pattern, pattern, pattern).ordered.limit(12)
      @blog_posts = BlogPost.published.where("title ILIKE ? OR excerpt ILIKE ? OR tags ILIKE ?", pattern, pattern, pattern).recent.limit(12)
      @faqs = Faq.published.where("question ILIKE ? OR answer ILIKE ?", pattern, pattern).ordered.limit(12)
    else
      @services = []
      @destinations = []
      @blog_posts = []
      @faqs = []
    end
  end
end
