[![Build Status](https://travis-ci.org/andela-bkanyolo/flyght.svg?branch=develop)](https://travis-ci.org/andela-bkanyolo/flyght)
[![Coverage Status](https://coveralls.io/repos/github/andela-bkanyolo/flyght/badge.svg?branch=develop)](https://coveralls.io/github/andela-bkanyolo/flyght?branch=develop)
[![Code Climate](https://codeclimate.com/github/andela-bkanyolo/flyght/badges/gpa.svg)](https://codeclimate.com/github/andela-bkanyolo/flyght)
[![Issue Count](https://codeclimate.com/github/andela-bkanyolo/flyght/badges/issue_count.svg)](https://codeclimate.com/github/andela-bkanyolo/flyght)
# FLYGHT
<img width="1440" alt="screen shot 2016-10-25 at 11 26 25" src="https://cloud.githubusercontent.com/assets/21033429/19678340/0a1baab6-9aa6-11e6-90fa-b08e999fdee9.png">
<img width="1440" alt="screen shot 2016-10-25 at 11 26 55" src="https://cloud.githubusercontent.com/assets/21033429/19678343/0b4eb784-9aa6-11e6-8b4e-7986c22e969b.png">
### INTRODUCTION
Flight is a flight management application that allows you to search for flights from around Africa and then book the flight. The live application can be accessed here:   http://flyghtrails.herokuapp.com/

### Features

#### Unregistered users

  Users who have not created an account on Flyght can do the following:

```Find flights by Origin, Destination and Date.```

```Specify number of passengers for travel```

```If any flights form that route exist, they can then select the flight for booking.```

```After specifying a valid email and booking, they will receive an email confirmation```

```They can view a booking by searching for its confirmation number```

```Sign up to become registered users```

### Registered users

  In addition to all features for unregistered users, registered users can also:

```List all their past bookings```

```Edit a past booking```

```Cancel a past booking, if it has not already departed```


## Local Set Up

  To get started with this application locally, you''ll need the following technologies:

  * Ruby
  * Git
  * The ruby gem `bundler`
  * `Rspec` for testing

### Installation

 Clone the repository:

    $  git clone https://github.com/andela-bkanyolo/flyght.git

 Navigate into the directory:

    $  cd flyght

 Install dependencies

    $  bundle install

 Create, migrate and seed database

    $ bundle exec rake db:setup

 Start the server

    $ rails server

 Visit http://localhost:3000 to view the application on your browser.

## Tests

Assuming you have setup the application as stated above, you can run the tests with

    $  bundle exec rspec


## Limitations
  * The application relies on seed data for airports, airlines and flights, hence the data is static and not an actual reprentation of real life flight searching platforms.
  * You can only have a maximum of 10 passengers per booking.
  * The user cannot pay for the flight booking.
  * Due to the above limitations, bookings are just for demonstration purposes and a  confirmed booking isn't valid anywhere other than in the application.
