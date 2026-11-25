class Service < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  enum :category, { travel: 0, visa: 1, study_abroad: 2, cac: 3 }, default: :travel

  has_rich_text :description
  has_one_attached :hero_image
  has_many_attached :flyers

  validates :title, :category, presence: true

  scope :published, -> { where(published: true) }
  scope :featured, -> { where(featured: true) }
  scope :ordered, -> { order(position: :asc, created_at: :asc) }

  def should_generate_new_friendly_id?
    slug.blank? || title_changed?
  end
end
