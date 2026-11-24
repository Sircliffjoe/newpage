class Email < ApplicationRecord
  belongs_to :sent_by, class_name: "User", optional: true

  enum :contact_type, {
    manual: "manual",
    lead: "lead",
    contact: "contact",
    newsletter: "newsletter",
    visa: "visa",
    study_abroad: "study_abroad",
    cac: "cac"
  }, default: :manual

  enum :status, {
    pending: "pending",
    sent: "sent",
    failed: "failed"
  }, default: :pending

  validates :recipient_email, :subject, :body, presence: true
  validates :recipient_email, format: { with: URI::MailTo::EMAIL_REGEXP }

  scope :recent, -> { order(created_at: :desc) }
end
