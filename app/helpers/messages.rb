module Messages
  def sign_up_welcome(user)
    "Welcome #{user.full_name}"
  end

  def log_in_success(user)
    "Welcome back, #{user.full_name}"
  end

  def log_in_error
    'Incorrect email or password.'
  end

  def log_out_goodbye(name)
    "GoodBye, #{name}"
  end

  def not_logged_in
    'Please sign up or log in to access this page.'
  end

  def invalid_route
    'Origin and Destination airport cannot be the same.'
  end

  def invalid_date_early
    'Date cannot be same as or earlier than current date.'
  end

  def invalid_date_late
    'Date cannot be later than one year from today.'
  end

  def invalid_date_format
    'Invalid date entered.'
  end

  def flights_found(num)
    "#{pluralize(num, 'flight')} found"
  end

  def no_flights_found
    'There are no flights available for this route'
  end

  def no_flight_selected
    'No flight was selected.'
  end

  def booking_saved
    'Your booking was successfully created.'
  end

  def booking_updated
    'Your booking was successfully updated.'
  end

  def booking_deleted
    'Your booking was successfully deleted!'
  end

  def booking_found
    'Booking found.'
  end

  def booking_not_found
    'Booking was not found.'
  end
end
