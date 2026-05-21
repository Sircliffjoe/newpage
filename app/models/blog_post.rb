class BlogPost < ApplicationRecord
  belongs_to :blog_category
  belongs_to :author, class_name: "User"

  extend FriendlyId
  friendly_id :title, use: :slugged

  enum :status, { draft: 0, published: 1 }, default: :draft

  has_rich_text :body
  has_one_attached :featured_image
end
