class Note < ApplicationRecord
  belongs_to :author
  belongs_to :notetable, polymorphic: true
end
