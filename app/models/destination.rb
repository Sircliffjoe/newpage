class Destination < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  enum :category, { travel: 0, study: 1 }, default: :travel

  has_rich_text :description
  has_one_attached :hero_image

  validates :name, :category, presence: true

  scope :published, -> { where(published: true) }
  scope :featured, -> { where(featured: true) }
  scope :ordered, -> { order(position: :asc, created_at: :asc) }

  def should_generate_new_friendly_id?
    slug.blank? || name_changed?
  end
end
