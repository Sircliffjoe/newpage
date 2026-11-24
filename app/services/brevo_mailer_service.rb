require "net/http"
require "uri"
require "json"

class BrevoMailerService
  API_URL = "https://api.brevo.com/v3/smtp/email".freeze

  Result = Struct.new(:success?, :message_id, :error, keyword_init: true)

  def self.send_email(to_email:, to_name: nil, subject:, html_content: nil, text_content: nil, reply_to: nil)
    new.send_email(
      to_email: to_email,
      to_name: to_name,
      subject: subject,
      html_content: html_content,
      text_content: text_content,
      reply_to: reply_to
    )
  end

  def send_email(to_email:, to_name: nil, subject:, html_content: nil, text_content: nil, reply_to: nil)
    api_key = ENV["BREVO_API_KEY"]

    if api_key.blank?
      Rails.logger.info("[BrevoMailerService] BREVO_API_KEY not configured. Simulated send to #{to_email}: #{subject}")
      return Result.new(success?: true, message_id: "dev-simulated-#{SecureRandom.hex(6)}")
    end

    uri = URI.parse(API_URL)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.open_timeout = 10
    http.read_timeout = 15

    payload = {
      sender: {
        name: ENV.fetch("BREVO_SENDER_NAME", "NewPage Integrity Travels"),
        email: ENV.fetch("BREVO_SENDER_EMAIL", "info@newpageintegritytravels.com")
      },
      to: [
        { email: to_email, name: to_name.presence || to_email }
      ],
      subject: subject
    }

    if html_content.present?
      payload[:htmlContent] = html_content
    else
      payload[:htmlContent] = ActionController::Base.helpers.simple_format(text_content.to_s)
    end
    payload[:textContent] = text_content if text_content.present?
    payload[:replyTo] = { email: reply_to } if reply_to.present?

    request = Net::HTTP::Post.new(uri.request_uri)
    request["accept"] = "application/json"
    request["content-type"] = "application/json"
    request["api-key"] = api_key
    request.body = payload.to_json

    response = http.request(request)
    parsed = JSON.parse(response.body) rescue {}

    if response.is_a?(Net::HTTPSuccess)
      Result.new(success?: true, message_id: parsed["messageId"])
    else
      error_msg = parsed["message"] || "HTTP #{response.code}: #{response.body}"
      Rails.logger.error("[BrevoMailerService] Delivery failed: #{error_msg}")
      Result.new(success?: false, error: error_msg)
    end
  rescue StandardError => e
    Rails.logger.error("[BrevoMailerService] Exception: #{e.message}")
    Result.new(success?: false, error: e.message)
  end
end
