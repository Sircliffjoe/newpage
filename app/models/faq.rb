class Faq < ApplicationRecord
  enum :category, {
    general: 0,
    travel: 1,
    visas: 2,
    study_abroad: 3,
    cac: 4
  }, default: :general

  validates :question, :answer, presence: true

  scope :published, -> { where(published: true) }
  scope :ordered, -> { order(position: :asc, created_at: :asc) }
end
