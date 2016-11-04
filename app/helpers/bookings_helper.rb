module BookingsHelper
  def total_booking_cost(flight, passengers)
    (flight.price * passengers.to_i).round(2)
  end

  def check_search(origin, destination, date)
    errors = []
    check_route(origin, destination, errors)
    check_date(date, errors)
    errors
  end

  private

  def check_route(origin, destination, errors)
    return unless origin == destination
    errors << 'Origin and Destination airport cannot be the same.'
  end

  def check_date(date, errors)
    date = Time.parse(date)
    if date < Time.now
      errors << 'Date cannot be same as or earlier than current date.'
    elsif date > Time.now + 1.year
      errors << 'Date cannot be later than one year from today.'
    end
  rescue ArgumentError
    errors << 'Invalid date entered.'
  end
end
