class TeamMember < ApplicationRecord
  has_one_attached :image

  validates :name, :role, presence: true

  scope :published, -> { where(published: true) }
  scope :ordered, -> { order(position: :asc, created_at: :asc) }
end
