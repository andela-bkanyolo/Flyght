module BookingsHelper
  def total_booking_cost(flight, passengers)
    (flight.price * passengers.to_i).round(2)
  end
end
