
class User < ApplicationRecord
  has_many :attending, :class_name => 'Attendee', :inverse_of => :user
  has_many :events, through: :attending
  has_many :my_events, :class_name => 'Event', :foreign_key => :owner_id, :inverse_of => :creator
  has_many :availabilities
  has_many :ranks, :class_name => 'Rank', :foreign_key => :ranker_id, :inverse_of => :ranker
  include PgSearch
  pg_search_scope :search_by_full_name, against: [:first_name, :last_name, :username], using: {tsearch: {prefix: true, highlight: {start_sel: '<b>', stop_sel: '</b>'}}}

  validates :first_name, presence: true, allow_blank: false, length: { in: 1..20 }
  validates :last_name, presence: true, allow_blank: false, length: { in: 1..20 }
  # username_regex = Regexp.escape("/^[a-z0-9]{1,30}$/i")
  username_regex = Regexp.escape('/[a-z0-9]/i')
  validates :username, presence: true, uniqueness: true, allow_blank: false, format: { with: /[a-z0-9]/i }, on: :create, length: { in: 1..30 }
  validates :password, presence: true, allow_blank: false, on: :create, length: { in: 6..15 }
  email_regex = Regexp.escape("/.+@.+\..+/i")
  validates :email, presence: true, format: { with: /.+@.+\..+/i }, length: { in: 7..100 }
  has_secure_password

  @@days_array = ["monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday"]
  @@times_array = ["morning", "day", "evening", "night"]

  def self.times_array
    @@times_array
  end

  def self.days_array
    @@days_array
  end

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
          schedule["#{day}"][@@times_array[0]] = is_available
        elsif index == 1
          schedule["#{day}"][@@times_array[1]] = is_available
        elsif index == 2
          schedule["#{day}"][@@times_array[2]] = is_available
        elsif index == 3
          schedule["#{day}"][@@times_array[3]] = is_available
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
          available["#{day}"][@@times_array[0]] = is_available
        elsif i == 1
          available["#{day}"][@@times_array[1]] = is_available
        elsif i == 2
          available["#{day}"][@@times_array[2]] = is_available
        elsif i == 3
          available["#{day}"][@@times_array[3]] = is_available
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

  def create_empty_week_hash(arg)
    # "arg" should be the type of empty value in the hash. The options are:
    # "boolean" = fills the hash with false booleans
    # "string" = fills the hash with "" empty strings
    # "nil" = fills the hash with nil values
    # "array" = fills the hash with empty arrays
    # "hash" = fills the hash with empty hashes
    emptyhash = Hash.new
    @@days_array.each do |d|
      emptyhash[d] = Hash.new
        @@times_array.each do |t|
          case arg
            when "boolean"
              emptyhash[d][t] = false
            when "string"
              emptyhash[d][t] = ""
            when "nil"
              emptyhash[d][t] = nil
            when "array"
              emptyhash[d][t] = Array.new
            when "hash"
              emptyhash[d][t] = Hash.new
            else
              emptyhash[d][t] = ""
          end
        end
    end
    return emptyhash
  end

  def free_this_week
    avail_contacts = self.get_available_contacts
    free_this_week_hash = create_empty_week_hash("array")
    avail_contacts.map do |contact_id, weekhash|
      # puts "Now looking at #{contact_id}"
      weekhash.map do |day, dayhash|
        # puts "now looking at #{day}"
        dayhash.select do |time, is_available|
          free_this_week_hash[day][time] << User.find(contact_id) if is_available
        end
      end
    end
    return free_this_week_hash
  end

  def free_today
    free_today_hash = self.free_this_week
    free_today_hash[Time.now.strftime("%A").downcase]
  end

  private

  def days_array
    ["monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday"]
  end

end
