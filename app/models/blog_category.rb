class BlogCategory < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :blog_posts, dependent: :restrict_with_error

  validates :name, presence: true, uniqueness: true

  def should_generate_new_friendly_id?
    slug.blank? || name_changed?
  end
end
