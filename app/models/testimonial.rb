class Testimonial < ApplicationRecord
  enum :service_type, { general: 0, travel: 1, visa: 2, study: 3, cac: 4 }, default: :general

  has_one_attached :image

  validates :client_name, :content, presence: true
  validates :rating, inclusion: { in: 1..5 }, allow_nil: true

  scope :published, -> { where(published: true) }
  scope :ordered, -> { order(position: :asc, created_at: :desc) }
end
