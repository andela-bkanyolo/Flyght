module UsersHelper
  def booking_expired(booking)
    booking.flight.departure_date(booking.departure) < Time.now
  end
end
