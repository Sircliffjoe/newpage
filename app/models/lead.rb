class Lead < ApplicationRecord
  belongs_to :assigned_to, class_name: "User", optional: true
  has_many :notes, as: :notetable, dependent: :destroy

  enum :status, { new_lead: 0, contacted: 1, pending: 2, converted: 3, closed: 4 }, default: :new_lead
  enum :service_type, { general: 0, travel: 1, visa: 2, study_abroad: 3, cac: 4 }, default: :general

  validates :name, presence: true, length: { maximum: 120 }
  validates :email, presence: true, length: { maximum: 254 }, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :phone, length: { maximum: 30 }, allow_blank: true
  validates :message, length: { maximum: 5000 }, allow_blank: true
end
