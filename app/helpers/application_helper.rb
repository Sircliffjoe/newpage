module ApplicationHelper
  def global_settings
    @global_settings ||= PageSetting.for("global")
  end

  def site_setting(key, default = nil)
    global_settings&.setting(key, default) || default
  end

  def page_setting_for(key)
    @page_settings_cache ||= {}
    @page_settings_cache[key.to_s] ||= PageSetting.for(key)
  end

  def cms_image_url(attachment, fallback_url)
    if attachment.respond_to?(:attached?) && attachment.attached?
      url_for(attachment)
    else
      fallback_url
    end
  end

  def whatsapp_number
    site_setting("whatsapp_number", "2348038656409").to_s.gsub(/\D/, "")
  end

  def whatsapp_link(message = nil)
    base = "https://wa.me/#{whatsapp_number}"
    message.present? ? "#{base}?text=#{CGI.escape(message)}" : base
  end
end
