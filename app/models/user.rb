class User < ApplicationRecord
  has_many :attending, :class_name => 'Attendee', :inverse_of => :user
  has_many :events, through: :attending
  has_many :my_events, :class_name => 'Event', :inverse_of => :owner
  has_many :availabilities
  has_many :ranks, :class_name => 'Rank', :inverse_of => :ranker

  def my_network
    list = Array.new
    self.ranks.each do |rank|
      list << { rankee: rank.rankee, rank: rank.rank }
      # a change has been made
    end
    list
  end

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def created_events
    Event.where("owner_id = #{self.id}")
  end
end
