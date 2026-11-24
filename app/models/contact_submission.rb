class ContactSubmission < ApplicationRecord
  before_validation :sanitize_fields

  validates :name, presence: true, length: { maximum: 120 }, format: { without: /[\r\n]/, message: "cannot contain line breaks" }
  validates :email, presence: true, length: { maximum: 254 }, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :phone, length: { maximum: 30 }, allow_blank: true
  validates :subject, length: { maximum: 200 }, format: { without: /[\r\n]/, message: "cannot contain line breaks" }, allow_blank: true
  validates :message, presence: true, length: { minimum: 5, maximum: 5000 }

  private

  def sanitize_fields
    self.name = name.to_s.strip
    self.email = email.to_s.strip.downcase
    self.phone = phone.to_s.strip.presence
    self.subject = subject.to_s.strip.presence
    self.message = message.to_s.strip
  end
end
