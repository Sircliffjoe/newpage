class Admin::PageSettingsController < Admin::BaseController
  before_action :set_page_setting, only: [:edit, :update]

  def index
    @page_settings = PageSetting.order(:page_name)
  end

  def edit; end

  def update
    if @page_setting.update(page_setting_params)
      redirect_to admin_page_settings_path, notice: "Page setting updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_page_setting
    @page_setting = PageSetting.find(params[:id])
  end

  def page_setting_params
    params.require(:page_setting).permit(:page_name, :meta_title, :meta_description, :og_image, :content, :settings)
  end
end
