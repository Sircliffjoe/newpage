class Admin::BlogCategoriesController < Admin::BaseController
  before_action :set_category, only: [:edit, :update, :destroy]

  def index
    @blog_categories = BlogCategory.all
  end

  def new
    @blog_category = BlogCategory.new
  end

  def edit; end

  def create
    @blog_category = BlogCategory.new(category_params)
    if @blog_category.save
      redirect_to admin_blog_categories_path, notice: "Category created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @blog_category.update(category_params)
      redirect_to admin_blog_categories_path, notice: "Category updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @blog_category.destroy
    redirect_to admin_blog_categories_path, notice: "Category deleted.", status: :see_other
  end

  private

  def set_category
    @blog_category = BlogCategory.find(params[:id])
  end

  def category_params
    params.require(:blog_category).permit(:name, :slug)
  end
end
