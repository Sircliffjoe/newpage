class BlogPost < ApplicationRecord
  belongs_to :blog_category
  belongs_to :author, class_name: "User"

  extend FriendlyId
  friendly_id :title, use: :slugged

  enum :status, { draft: 0, published: 1 }, default: :draft

  has_rich_text :body
  has_one_attached :featured_image

  validates :title, presence: true

  scope :featured, -> { where(featured: true) }
  scope :recent, -> { order(Arel.sql("COALESCE(published_at, created_at) DESC")) }

  before_save :set_published_at

  def should_generate_new_friendly_id?
    slug.blank? || title_changed?
  end

  private

  def set_published_at
    self.published_at ||= Time.current if published?
  end
end
