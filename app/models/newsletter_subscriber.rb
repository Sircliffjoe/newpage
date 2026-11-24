class NewsletterSubscriber < ApplicationRecord
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: URI::MailTo::EMAIL_REGEXP }

  before_validation :normalize_email
  before_create :set_subscribed_at

  scope :active, -> { where(unsubscribed_at: nil) }

  private

  def normalize_email
    self.email = email.to_s.strip.downcase
  end

  def set_subscribed_at
    self.subscribed_at ||= Time.current
  end
end
