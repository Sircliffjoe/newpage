class Rack::Attack
  # Throttle login attempts by IP
  throttle("logins/ip", limit: 10, period: 5.minutes) do |req|
    req.ip if req.path == "/users/sign_in" && req.post?
  end

  # Throttle contact & consultation form submissions by IP
  throttle("contact/ip", limit: 5, period: 10.minutes) do |req|
    req.ip if req.path == "/contact" && req.post?
  end

  # Throttle newsletter signups by IP
  throttle("newsletter/ip", limit: 5, period: 10.minutes) do |req|
    req.ip if req.path == "/newsletter_subscribers" && req.post?
  end
end
