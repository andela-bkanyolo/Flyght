module UsersHelper
  def booking_expired(booking)
    p booking.flight.departure_date(booking.flight.departure)
    p Time.now
    booking.flight.departure_date(booking.departure) < Time.now
  end
end
