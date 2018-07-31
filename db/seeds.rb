# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Attendee.destroy_all
Availability.destroy_all
Event.destroy_all
Location.destroy_all
Rank.destroy_all
User.destroy_all

dan = User.create(first_name: "Dan", last_name: "Chung", username: "danchung", email: "test@test.com")
marlon = User.create(first_name: "Marlon", last_name: "DuPain", username: "marond", email: "test@test.com")
alex = User.create(first_name: "Alex", last_name: "Neustein", username: "alexn", email: "test@test.com")

event_1 = Event.create(owner_id: dan.id, name: "Event 1", description: "The description of this event.", date: Time.now, location_id: 1)
