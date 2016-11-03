module BookingsHelper
  def total_booking_cost(flight, passengers)
    (flight.price * passengers.to_i).round(2)
  end

  def date_no_time(date)
  end

  def time_no_date(date)
  end
end
