# # This file should contain all the record creation needed to seed the database with its default values.
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

test_pw = BCrypt::Password.create("test")

1000.times do
  the_first_name = Faker::Name.first_name
  the_last_name = Faker::Name.last_name
  the_username = Faker::Internet.user_name("#{the_first_name} #{the_last_name}", %w(. _ -))
  the_email = Faker::Internet.email("#{the_first_name}+#{the_last_name}")
  the_birthdate = Faker::Date.birthday(18, 65).to_s
  User.create(first_name: the_first_name, last_name: the_last_name, username: the_username, email: the_email, password_digest: test_pw, birthdate: the_birthdate)
  User.last.open_schedule
end

50.times do
  Rank.create(rankee_id: Faker::Number.unique.between(1..50), ranker_id: Faker::Number.unique.between(50..100), rank: Faker::Number.between(1..5))
end

25.times do
  Rank.create(rankee_id: Faker::Number.unique.between(50..100), ranker_id: Faker::Number.unique.between(1..50), rank: Faker::Number.between(1..5))
end

60.times do
  Location.create(name: Faker::Company.name, address: Faker::Address.full_address, description: Faker::Lorem.paragraph)
end


40.times do
  Event.create(owner_id: Faker::Number.unique.between(1, 100), name: Faker::Hipster.unique.sentence(1..3), description: Faker::Hipster.sentence(5..10), date: Faker::Time.forward(7, :all).to_s[0..-7], location_id: Faker::Number.unique.between(1, 60))
end

30.times do
  Attendee.create(user_id: Faker::Number.unique.between(1, 1000), event_id: Faker::Number.between(1, 40))
end
# dan = User.create(first_name: "Dan", last_name: "Chung", username: "dan", email: "test@test.com", password_digest: test_pw)
# marlon = User.create(first_name: "Marlon", last_name: "DuPain", username: "marlon", email: "test@test.com", password_digest: test_pw)
# alex = User.create(first_name: "Alex", last_name: "Neustein", username: "alex", email: "test@test.com", password_digest: test_pw)
#
# flatiron = Location.create(name: "Flatiron School", address: "123 Lovely Lane", description: "#1 School")
#
# bridge_fresh = Location.create(name: "Bridge Fresh", address: "245 Lonely Lane", description: "#1 Deli")
# event_1 = Event.create(owner_id: dan.id, name: "Event 1", description: "The description of this event.", date: Time.now, location_id: flatiron.id)
# event_2 = Event.create(owner_id: marlon.id, name: "Event 2", description: "The description of this event 2.", date: Time.now, location_id: bridge_fresh.id)
# event_3 = Event.create(owner_id: alex.id, name: "Event 3", description: "The description of this event 3.", date: Time.now, location_id: flatiron.id)
#
# Attendee.create(user_id: dan.id, event_id: event_3.id)
# Attendee.create(user_id: marlon.id, event_id: event_1.id)
# Attendee.create(user_id: alex.id, event_id: event_1.id)
# Attendee.create(user_id: dan.id, event_id: event_2.id)
# Attendee.create(user_id: alex.id, event_id: event_2.id)
# Attendee.create(user_id: marlon.id, event_id: event_3.id)
#
# # all = {"morning" => true, "day" => true, "evening" => true, "night" => true }
# # random = {"morning" => true, "day" => false, "evening" => true, "night" => false}
# all = 1111
# random = 1010
# Availability.create(user_id: dan.id, monday: all, tuesday: all, wednesday: all, thursday: all, friday: all, saturday: all, sunday: all)
# Availability.create(user_id: marlon.id, monday: all, tuesday: random, wednesday: all, thursday: random, friday: all, saturday: all, sunday: random)
# Availability.create(user_id: alex.id, monday: random, tuesday: random, wednesday: all, thursday: random, friday: random, saturday: all, sunday: random)
#
# Rank.create(ranker_id: dan.id, rankee_id: marlon.id, rank: 3)
# Rank.create(ranker_id: dan.id, rankee_id: alex.id, rank: 4)
# Rank.create(ranker_id: marlon.id, rankee_id: dan.id, rank: 2)
# Rank.create(ranker_id: alex.id, rankee_id: dan.id, rank: 1)
# Rank.create(ranker_id: alex.id, rankee_id: marlon.id, rank: 5)
