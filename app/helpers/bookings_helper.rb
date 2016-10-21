module BookingsHelper
  def total_booking_cost(flight, passengers)
    total = (flight.price * passengers.to_i).round(2)  #helper or js
  end
end
