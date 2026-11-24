class Admin::PageSettingsController < Admin::BaseController
  before_action :require_content_editor!
  before_action :set_page_setting, only: [ :edit, :update, :destroy ]

  def index
    @page_settings = PageSetting.order(:page_name)
  end

  def new
    @page_setting = PageSetting.new
  end

  def create
    @page_setting = PageSetting.new(processed_params)
    if @page_setting.save
      redirect_to admin_page_settings_path, notice: "Page setting created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @page_setting.update(processed_params)
      redirect_to admin_page_settings_path, notice: "Page setting updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @page_setting.destroy
    redirect_to admin_page_settings_path, notice: "Page setting deleted.", status: :see_other
  end

  private

  def set_page_setting
    @page_setting = PageSetting.find(params[:id])
  end

  def page_setting_params
    params.require(:page_setting).permit(
      :key, :page_name, :slug, :hero_title, :hero_subtitle,
      :meta_title, :meta_description, :content, :rich_content,
      :hero_image, :section_image, :og_image, :settings
    )
  end

  def processed_params
    attrs = page_setting_params.to_h
    if attrs["settings"].is_a?(String)
      raw = attrs["settings"].strip
      if raw.blank?
        attrs["settings"] = {}
      else
        begin
          attrs["settings"] = JSON.parse(raw)
        rescue JSON::ParserError
          attrs.delete("settings")
        end
      end
    end
    attrs
  end
end
