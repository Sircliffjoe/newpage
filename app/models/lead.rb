class Lead < ApplicationRecord
  enum :status, { new_lead: 0, contacted: 1, pending: 2, converted: 3, closed: 4 }, default: :new_lead
  enum :service_type, { general: 0, travel: 1, visa: 2, study_abroad: 3, cac: 4 }, default: :general
end
