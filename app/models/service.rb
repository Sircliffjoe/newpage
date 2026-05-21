class Service < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  enum :category, { travel: 0, visa: 1, study_abroad: 2, cac: 3 }

  has_rich_text :description
  has_one_attached :hero_image
end
