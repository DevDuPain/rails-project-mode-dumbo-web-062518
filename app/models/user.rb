class User < ApplicationRecord
  has_many :attending, :class_name => 'Attendee', :inverse_of => :user
  has_many :events, through: :attending
  has_many :my_events, :class_name => 'Event', :inverse_of => :owner
  has_many :availabilities
  has_many :ranks, :class_name => 'Rank', :inverse_of => :ranker

  def my_network
    self.ranks.rankee.map do |rankee|
      rankee
      # a change has been made
    end
  end
end
