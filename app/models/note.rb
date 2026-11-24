class Note < ApplicationRecord
  belongs_to :author, class_name: "User"
  belongs_to :notetable, polymorphic: true

  validates :body, presence: true
end
