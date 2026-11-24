require "csv"

class Admin::NewsletterSubscribersController < Admin::BaseController
  before_action :set_newsletter_subscriber, only: [:destroy]

  def index
    @newsletter_subscribers = NewsletterSubscriber.order(created_at: :desc)
  end

  def destroy
    @newsletter_subscriber.destroy
    redirect_to admin_newsletter_subscribers_path, notice: "Subscriber removed.", status: :see_other
  end

  def export
    subscribers = NewsletterSubscriber.active.order(created_at: :desc)
    csv_data = CSV.generate(headers: true) do |csv|
      csv << ["Email", "Subscribed At"]
      subscribers.each do |sub|
        csv << [sub.email, (sub.subscribed_at || sub.created_at).iso8601]
      end
    end

    send_data csv_data, filename: "newpage-subscribers-#{Date.current}.csv", type: "text/csv"
  end

  private

  def set_newsletter_subscriber
    @newsletter_subscriber = NewsletterSubscriber.find(params[:id])
  end
end
