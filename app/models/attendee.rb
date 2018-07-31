class Attendee < ApplicationRecord
  belongs_to :user, :inverse_of => :attending
  belongs_to :event, :inverse_of => :attendees
end
