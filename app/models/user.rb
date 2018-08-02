
class User < ApplicationRecord
  has_many :attending, :class_name => 'Attendee', :inverse_of => :user
  has_many :events, through: :attending
  has_many :my_events, :class_name => 'Event', :foreign_key => :owner_id, :inverse_of => :creator
  has_many :availabilities
  has_many :ranks, :class_name => 'Rank', :foreign_key => :ranker_id, :inverse_of => :ranker
  include PgSearch
  pg_search_scope :search_by_full_name, against: [:first_name, :last_name, :username], using: {tsearch: {prefix: true, highlight: {start_sel: '<b>', stop_sel: '</b>'}}}

  has_secure_password

  def open_schedule
    if self.availabilities.size == 0
      Availability.create(user_id: self.id, monday: 1111, tuesday: 1111, wednesday: 1111, thursday: 1111, friday: 1111, saturday: 1111, sunday: 1111)
    end
  end

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

  def schedule
    schedule = {}

    days_array.each do |day|
      self_available = self.availabilities[0][:"#{day}"].split("")

      schedule["#{day}"] = {}

      self_available.each_with_index do |avail, index|
        is_available = false

        if avail.to_i == 1
          is_available = true
        end

        if index == 0
          schedule["#{day}"]["morning"] = is_available
        elsif index == 1
          schedule["#{day}"]["day"] = is_available
        elsif index == 2
          schedule["#{day}"]["evening"] = is_available
        elsif index == 3
          schedule["#{day}"]["night"] = is_available
        end
      end
    end

    schedule
    ## returns hash of available days and blocks
  end

  def compare_availability(user)
    available = {}

    days_array.each do |day|
      self_available = self.availabilities[0][:"#{day}"].split("")
      user_available = user.availabilities[0][:"#{day}"].split("")

      available["#{day}"] = {}

      for i in 0...4 do
        is_available = false

        if self_available[i] == user_available[i] && self_available[i].to_i == 1
          is_available = true
        end

        if i == 0
          available["#{day}"]["morning"] = is_available
        elsif i == 1
          available["#{day}"]["day"] = is_available
        elsif i == 2
          available["#{day}"]["evening"] = is_available
        elsif i == 3
          available["#{day}"]["night"] = is_available
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

  def suggest_available_contacts
    self.get_available_contacts
  end

  private

  def days_array
    ["monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday"]
  end

end
