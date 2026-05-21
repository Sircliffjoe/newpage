class Testimonial < ApplicationRecord
  enum :service_type, { general: 0, travel: 1, visa: 2, study: 3, cac: 4 }, default: :general

  has_one_attached :image
end
