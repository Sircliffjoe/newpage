class Admin::NewsletterSubscribersController < Admin::BaseController
  before_action :set_newsletter_subscriber, only: [:destroy]

  def index
    @newsletter_subscribers = NewsletterSubscriber.order(created_at: :desc)
  end

  def destroy
    @newsletter_subscriber.destroy
    redirect_to admin_newsletter_subscribers_path, notice: "Subscriber removed.", status: :see_other
  end

  private

  def set_newsletter_subscriber
    @newsletter_subscriber = NewsletterSubscriber.find(params[:id])
  end

  def newsletter_subscriber_params
    params.require(:newsletter_subscriber).permit(:email)
  end
end
