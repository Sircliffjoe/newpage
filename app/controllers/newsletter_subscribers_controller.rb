class NewsletterSubscribersController < ApplicationController
  def create
    email = params.dig(:newsletter_subscriber, :email) || params[:email]
    @subscriber = NewsletterSubscriber.find_or_initialize_by(email: email.to_s.strip.downcase)
    @subscriber.unsubscribed_at = nil

    if @subscriber.save
      redirect_back fallback_location: root_path,
                    notice: "Welcome! You have been subscribed to NewPage Integrity travel & visa updates."
    else
      redirect_back fallback_location: root_path,
                    alert: @subscriber.errors.full_messages.to_sentence.presence || "Please enter a valid email address."
    end
  end
end
