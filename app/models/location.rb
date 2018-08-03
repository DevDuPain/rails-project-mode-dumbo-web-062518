class Location < ApplicationRecord
  has_many :events
  validates :name, presence: true, allow_blank: false, length: { in: 1..50 }
  validates :address, presence: true, allow_blank: false, length: { in: 1..100 }
  validates :description, presence: true, allow_blank: false, length: { in: 1..1000 }
end
