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

  def safe_external_url(url)
    return nil if url.blank?

    uri = URI.parse(url.to_s.strip)
    uri.to_s if uri.is_a?(URI::HTTP) || uri.is_a?(URI::HTTPS)
  rescue URI::InvalidURIError
    nil
  end

  def spam_protection_fields
    token = Rails.application.message_verifier(:form_spam_protection).generate(Time.current.to_i)
    safe_join([
      hidden_field_tag(:_form_loaded_at, token),
      content_tag(:div, style: "position:absolute;left:-9999px;top:auto;width:1px;height:1px;overflow:hidden;", aria: { hidden: true }) do
        label_tag(:website_url, "Leave this field blank") +
          text_field_tag(:website_url, nil, tabindex: -1, autocomplete: "off")
      end
    ])
  end
end
