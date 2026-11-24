class GalleryImage < ApplicationRecord
  has_one_attached :image

  enum :category, {
    travel: 0,
    visa_approvals: 1,
    students: 2,
    office: 3,
    events: 4
  }, default: :travel

  validates :title, presence: true

  scope :published, -> { where(published: true) }
  scope :ordered, -> { order(position: :asc, created_at: :desc) }
end
