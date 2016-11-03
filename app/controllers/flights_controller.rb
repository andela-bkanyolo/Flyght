class FlightsController < ApplicationController
  def home
    @airports = Airport.airports_by_geography
  end

  def index
    origin = params[:origin]
    destination = params[:destination]
    passengers = params[:passengers]
    date = params[:date]
    @search = FlightSearch.new(origin, destination, passengers, date)
  end
end
