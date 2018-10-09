# "Kevin"
The IRL Social Assistant

Created by [Alex Neustein](https://github.com/alexneustein), [Marlon DuPain](https://github.com/DevDuPain), and [Daniel Chung](https://github.com/dlchung)

Built in Ruby on Rails, PostgreSQL, and Bootstrap.

The IRL Social Assistant, aka "Kevin", is designed to provide a medium for implicit communication between you and your contacts, acquaintances, and friends. Allow Kevin to compare your available times with the available times of those you know, or don't know.

* Not sure when your 109 acquaintances are available to hangout this week? **_No problem_**. Kevin can help. Your IRL Social Assistant will tell you who can meet up with you for dinner on Wednesday night.

* Don't enjoy the company of certain others? **_No problem_**. Let Kevin know how much you dislike them using our Ranking system. Your IRL Social Assistant will no longer show their availability to you. It also goes both ways. Has Mary been unavailable for the past 3 months? Maybe it was something you said?

* Create social events with Kevin. Only your mutual highly ranked contacts will know about your Pajama Party on Friday night.

## Gems
* pg_search
* select2-rails

## Setup Instructions
Install required gems:

    bundle install

Setup database:

    rails db:setup

Start your local rails server:

    rails s

Don't forget to start your PostgreSQL server.

---

## Requirements:

1. You should have least five models. You do not have to have all of these built out on day one. But by the end of the week, you should have at least five models.

2. Some methods in your models. There should be at least twenty methods total in your models. These are to be used to better extract data from your tables. Think Flatiron BnB Lab

3. No APIs until you get approval from an instructor.  The reason is because API's oftentimes leads you to learning the specific API really well, but not learning Rails that well.  Rails is a more transferable skill.  So stick with that.

4. Specs - there should be at least 10 specs in your project (five per person).

5. An analytics page - The main learning goal of this is to get you to write some interesting activerecord queries.

6. No JavaScript. Stay focused on Rails for this project - we'll have plenty of time this semeseter to cover JS topics.

## Project Task Guidelines
- come up with idea, model out domain.
- add model tests, start building out basic features. Have some functionality built out by the end of the day.
- Iterate on the features that you built yesterday. Go from a 'skateboard' version to a scooter or a bicycle. It doesnt' have to be perfect, but it should be working.
- start styling/ cleaning up issues.
- issue cleanup and final demos.
