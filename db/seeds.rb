# This file should contain all the record creation needed to seed the database with its default values.
# # The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
# #
# # Examples:
# #
# #   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
# #   Character.create(name: 'Luke', movie: movies.first)
#
Attendee.destroy_all
Availability.destroy_all
Event.destroy_all
Location.destroy_all
Rank.destroy_all
User.destroy_all

# test_pw = BCrypt::Password.create("test")
test_pw = "testing"

###################
## How many users?#
## Must be > 100
num_users = 200
###################

def generate_availability
  avail = [rand(0..1), rand(0..1), rand(0..1), rand(0..1)]
  avail = avail.join("")
end

system "clear"
puts "Starting seed..."

##
## Populate Users and their Availiabilities
puts "Populating users and availabilities..."

test_user = User.create(first_name: "Testy", last_name: "McTesterson", username: "tester", email: "test@testing.com", password: test_pw, password_confirmation: test_pw, birthdate: "2000/01/01")
Availability.create(user_id: test_user.id, monday: generate_availability, tuesday: generate_availability, wednesday: generate_availability, thursday: generate_availability, friday: generate_availability, saturday: generate_availability, sunday: generate_availability)

num_users.times do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name

  if rand(1..2) == 1
    username = Faker::Internet.unique.user_name(5..19)
  else
    username = Faker::Internet.unique.user_name(5..15)
    username = username + rand(1..9999).to_s
  end

  if rand(1..2) == 1
    email = Faker::Internet.free_email("#{first_name}+#{last_name}")
  else
    email = Faker::Internet.email("#{first_name}+#{last_name}")
  end

  birthdate = Faker::Date.birthday(18, 65).to_s
  # user = User.create(first_name: first_name, last_name: last_name, username: username, email: email, password_digest: test_pw, birthdate: birthdate)
  user = User.create(first_name: first_name, last_name: last_name, username: username, email: email, password: test_pw, password_confirmation: test_pw, birthdate: birthdate)

  Availability.create(user_id: user.id, monday: generate_availability, tuesday: generate_availability, wednesday: generate_availability, thursday: generate_availability, friday: generate_availability, saturday: generate_availability, sunday: generate_availability)
end
puts "#{User.all.count} done."
users = User.all

##
## Populate Ranks
puts "Populating ranks..."
(num_users * 10).times do
  user = users.sample
  selected = [user]
  user_2 = (users - selected).sample

  Rank.create(ranker_id: user.id, rankee_id: user_2.id, rank: rand(1..5))
end
puts "#{Rank.all.count} done."
puts "Done."

##
## Populate Locations
puts "Populating locations..."
(num_users / 5).times do
  Location.create(name: Faker::Company.name, address: Faker::Address.full_address, description: Faker::Lorem.paragraph)
end
puts "#{Location.all.count} done."
locations = Location.all

##
## Populate Events
puts "Populating events..."
(num_users * 3).times do
  user = users.sample
  location = locations.sample
  rank = rand(1..5)

  Event.create(owner_id: user.id, name: Faker::Hipster.unique.sentence(rand(1..3)), description: Faker::Hipster.sentence(rand(5..10)), date: Faker::Time.forward(7, :all).to_s[0..-7], location_id: location.id, required_rank: rank)
end
puts "#{Event.all.count} done."
events = Event.all

##
## Populate Attendees
puts "Populating attendees..."
(num_users * 5).times do
  user = users.sample
  event = events.sample
  Attendee.create(user_id: user.id, event_id: event.id)
end
puts "#{Attendee.all.count} done."

puts "Seeding done!"
