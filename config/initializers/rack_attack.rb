class Rack::Attack
  # Block automated vulnerability scanners and CMS probes
  blocklist("block/scanners") do |req|
    req.path.match?(%r{\A/(wp-admin|wp-login\.php|xmlrpc\.php|phpmyadmin|\.env|\.git(/|\z))}i) ||
      req.path.end_with?(".php")
  end

  # Throttle login attempts by IP
  throttle("logins/ip", limit: 10, period: 5.minutes) do |req|
    req.ip if req.path == "/users/sign_in" && req.post?
  end

  # Throttle login attempts by normalized email (stops distributed credential stuffing)
  throttle("logins/email", limit: 5, period: 5.minutes) do |req|
    if req.path == "/users/sign_in" && req.post?
      req.params.dig("user", "email").to_s.strip.downcase.presence
    end
  end

  # Throttle password reset requests by IP
  throttle("password_resets/ip", limit: 5, period: 15.minutes) do |req|
    req.ip if req.path == "/users/password" && req.post?
  end

  # Throttle contact & consultation form submissions by IP
  throttle("contact/ip", limit: 5, period: 10.minutes) do |req|
    req.ip if req.path == "/contact" && req.post?
  end

  # Throttle contact submissions by email address
  throttle("contact/email", limit: 3, period: 10.minutes) do |req|
    if req.path == "/contact" && req.post?
      req.params.dig("contact_submission", "email").to_s.strip.downcase.presence
    end
  end

  # Throttle newsletter signups by IP
  throttle("newsletter/ip", limit: 5, period: 10.minutes) do |req|
    req.ip if req.path == "/newsletter_subscribers" && req.post?
  end

  # Throttle sitewide search to prevent ILIKE query DoS
  throttle("search/ip", limit: 30, period: 1.minute) do |req|
    req.ip if req.path == "/search" && req.get?
  end

  self.throttled_responder = lambda do |request|
    match_data = request.env["rack.attack.match_data"] || {}
    retry_after = (match_data[:period] || 60).to_s
    [
      429,
      { "Content-Type" => "text/plain", "Retry-After" => retry_after },
      [ "Too many requests. Please wait a moment and try again.\n" ]
    ]
  end
end
