require_relative "../../lib/brevo_delivery_method"

ActionMailer::Base.add_delivery_method :brevo, BrevoDeliveryMethod
