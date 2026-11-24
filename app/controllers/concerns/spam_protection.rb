module SpamProtection
  extend ActiveSupport::Concern

  MIN_SUBMIT_SECONDS = 2
  MAX_FORM_AGE_SECONDS = 12.hours.to_i
  MAX_ALLOWED_URLS = 3

  private

  def spam_submission?(content: nil)
    # 1. Honeypot check (always active, including tests)
    if params[:website_url].present?
      Rails.logger.warn("[SpamProtection] Honeypot triggered from IP #{request.remote_ip}")
      return true
    end

    # 2. Signed form-load timestamp check
    token = params[:_form_loaded_at].presence
    if token.present?
      return true unless valid_form_timestamp?(token)
    elsif !Rails.env.test?
      Rails.logger.warn("[SpamProtection] Missing form timestamp token from IP #{request.remote_ip}")
      return true
    end

    # 3. Content heuristics (URL flooding / spam links)
    if content.present? && url_count(content) > MAX_ALLOWED_URLS
      Rails.logger.warn("[SpamProtection] Excessive URLs detected from IP #{request.remote_ip}")
      return true
    end

    false
  end

  def valid_form_timestamp?(token)
    loaded_at = Rails.application.message_verifier(:form_spam_protection).verify(token).to_i
    elapsed = Time.current.to_i - loaded_at
    if elapsed < MIN_SUBMIT_SECONDS || elapsed > MAX_FORM_AGE_SECONDS
      Rails.logger.warn("[SpamProtection] Suspicious submit timing (#{elapsed}s) from IP #{request.remote_ip}")
      return false
    end
    true
  rescue ActiveSupport::MessageVerifier::InvalidSignature, ArgumentError
    Rails.logger.warn("[SpamProtection] Invalid form timestamp signature from IP #{request.remote_ip}")
    false
  end

  def url_count(text)
    text.to_s.scan(%r{https?://|www\.}i).size
  end
end
