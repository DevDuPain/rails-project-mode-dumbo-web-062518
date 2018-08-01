class Event < ApplicationRecord
  has_many :attendees
  has_many :users, through: :attendees
  belongs_to :creator, :class_name => 'User', :foreign_key => 'owner_id', :inverse_of => :my_events
  belongs_to :location
  accepts_nested_attributes_for :location
end
