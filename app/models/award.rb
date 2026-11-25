class Award < ApplicationRecord
  has_one_attached :image

  enum :recipient_type, { company: 0, founder: 1 }, default: :company

  validates :title, :recipient_type, :recipient_name, :issuing_organization, presence: true

  scope :published, -> { where(published: true) }
  scope :featured, -> { where(featured: true) }
  scope :ordered, -> { order(position: :asc, awarded_on: :desc, created_at: :desc) }

  def recipient_label
    founder? ? "Founder & CEO" : "Company Award"
  end

  def award_year
    awarded_on&.year
  end
end
