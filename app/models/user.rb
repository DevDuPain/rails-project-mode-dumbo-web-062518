class User < ApplicationRecord
  has_many :attending, :class_name => 'Attendee', :inverse_of => :user
  has_many :events, through: :attending
  has_many :my_events, :class_name => 'Event', :inverse_of => :owner
  has_many :availabilities
  has_many :ranks, :class_name => 'Rank', :foreign_key => :ranker_id, :inverse_of => :ranker

  def my_network
    self.ranks.map do |rank|
      { rankee: rank.rankee, rank: rank.rank }
    end
    ## returns array of hashes
  end

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def created_events
    Event.where("owner_id = #{self.id}")
  end

  def get_ranked_contacts(passed_rank = 3)
    contacts_ranks = self.ranks.select { |rank| rank.rank >= passed_rank }
    contacts_ranks.map do |rank|
      rank.rankee
    end
    ## returns array of ranked contacts
  end

  def get_available_contacts
    self.get_ranked_contacts.each do |contact|
      
    end
  end
end
