class User < ApplicationRecord
  has_many :attending, :class_name => 'Attendee', :inverse_of => :user
  has_many :events, through: :attending
  has_many :my_events, :class_name => 'Event', :foreign_key => :owner_id, :inverse_of => :creator
  has_many :availabilities
  has_many :ranks, :class_name => 'Rank', :foreign_key => :ranker_id, :inverse_of => :ranker

  has_secure_password

  def my_network
    self.ranks.map do |rank|
      { rankee: rank.rankee, rank: rank.rank }
    end
    ## returns array of hashes
  end

  # def my_network_hash
  #   self.ranks.map do |rank|
  #     {rank.rankee: rank.rank }
  #   end
    ## returns array of hashes
  # end

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

  def compare_availability(user)
    days = ["monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday"]
    available = Hash.new

    days.each do |day|
      self_available = self.availabilities[0][:"#{day}"].split("")
      user_available = user.availabilities[0][:"#{day}"].split("")

      for i in 0...4 do
        if self_available[i] == user_available[i]
          if i == 0
            available["#{day}"] = { "morning" => true }
          elsif i == 1
            available["#{day}"] = { "day" => true }
          elsif i == 2
            available["#{day}"] = { "evening" => true }
          elsif i == 3
            available["#{day}"] = { "night" => true }
          end
        end
      end
    end

    available
    ## returns hash of available days and blocks
  end

  def get_available_contacts
    available_contacts = Hash.new

    self.get_ranked_contacts.each do |contact|
      available_contacts[contact.id] = compare_availability(contact)
    end

    available_contacts
    ## returns hash of user_ids => availability hash
  end

end
