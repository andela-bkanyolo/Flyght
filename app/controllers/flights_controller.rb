class FlightsController < ApplicationController
  def index
    @airports = Airport.order(country: :asc,
      city: :asc, name: :asc, code: :asc)
    #@flights = Flight.generate_flights(3005, 1526, Time.now)

    origin = params[:origin]
    destination = params[:destination]
    passengers = params[:passengers]
    date = params[:date]

    if origin && destination && passengers && date
      origin = origin.to_i
      destination = destination.to_i
      passengers = passengers.to_i
      date = Time.parse(date)
      @flights = Flight.generate_flights(origin, destination, date)
      @passengers = passengers
    end

  end

  private

  def flight_params
    params.require().permit()
  end
end
