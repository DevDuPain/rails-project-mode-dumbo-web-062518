class Location < ApplicationRecord
  has_many :events
  validates :name, presence: true, allow_blank: false, length: { in: 1..20 }
  validates :address, presence: true, allow_blank: false, length: { in: 1..40 }
  validates :description, presence: true, allow_blank: false, length: { in: 1..280 }
end
