class Event < ApplicationRecord
  has_many :attendees
  has_many :users, through: :attendees
  belongs_to :creator, :class_name => 'User', :foreign_key => 'owner_id', :inverse_of => :my_events
  belongs_to :location
  accepts_nested_attributes_for :location

  validates :owner_id, presence: true, on: :create
  validates :name, presence: true, allow_blank: false, length: { in: 1..70 }
  validates :description, presence: true, allow_blank: false, length: { in: 1..280 }
  validates :date, presence: true
  validates :location_id, presence: true
  validates :required_rank, presence: true

   def location_attributes=(location)
     if self.location == nil
       self.location = Location.find_or_create_by(name: location["name"])
       self.location.update(location)
     end
   end

   def self.get_suggested_events(user)
     users_ranks = Rank.where("rankee_id = #{user.id}")
     users_good_ranks = users_ranks.select { |rank| rank.rank > 1 }

     user_ranked = Rank.where("ranker_id = #{user.id}")

     events = Event.all
     good_events = []
     users_good_ranks.each do |rank|
       events.each do |event|
         if event.owner_id == rank.ranker_id
           good_events << event
         end
       end
     end

     good_events
   end

end
