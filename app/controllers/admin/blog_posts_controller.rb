class Admin::BlogPostsController < Admin::BaseController
  before_action :set_blog_post, only: [:show, :edit, :update, :destroy]

  def index
    @blog_posts = BlogPost.includes(:blog_category, :author).order(created_at: :desc)
  end

  def show; end
  def new
    @blog_post = BlogPost.new
  end
  def edit; end

  def create
    @blog_post = BlogPost.new(blog_post_params)
    @blog_post.author = current_user
    if @blog_post.save
      redirect_to admin_blog_posts_path, notice: "Blog post created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @blog_post.update(blog_post_params)
      redirect_to admin_blog_posts_path, notice: "Blog post updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @blog_post.destroy
    redirect_to admin_blog_posts_path, notice: "Blog post deleted.", status: :see_other
  end

  private

  def set_blog_post
    @blog_post = BlogPost.find(params[:id])
  end

  def blog_post_params
    params.require(:blog_post).permit(:title, :blog_category_id, :body, :featured_image, :excerpt, :tags, :status, :published_at)
  end
end
