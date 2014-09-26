# Odin Flight Booker

A [test-driven development](http://en.wikipedia.org/wiki/Test-driven_development "Test Driven Development") of a one-way flight booker using nested forms and mailers for The Odin Project's [Project: Advanced Forms](http://www.theodinproject.com/ruby-on-rails/building-advanced-forms "Advanced Forms") and [Project: Ruby on Rails Mailers](http://www.theodinproject.com/ruby-on-rails/sending-confirmation-emails "Mailers").

## Tests

Run the test suite with `rake` or `rspec spec/`.

## Setup

Run `rake db:seed` (after migrating the database) to create the faux data used for booking flights. 
_Note that the seed file deletes all data in a couple of database tables (`airports` and `flights`) before repopulating them. This was done because of the large amount of data created for the flights table. **You may customize how much data is created from the `db/seeds.rb` file before seeding the database**_.

## Usage

The flow of the flight booking app is as follows:

1. Choose desired airports, number of passengers, date; then Search
2. Choose Flight from among the available flights
3. Enter information about each passenger; then Book Flight

Only flights on days in the future may be booked. _(If no **Flight dates** are available from the search page, you will have to run `rake db:seed` to generate data for some future flights.)_ 

## Email

Be aware that the app will send a thank you email to all passengers after a booking is made.

---

**_[View on Heroku](http://dna-flight-booker.herokuapp.com/ "Flight Booker")._**
