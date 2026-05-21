class Destination < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  enum :category, { travel: 0, study: 1 }

  has_rich_text :description
  has_one_attached :hero_image
end
