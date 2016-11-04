class FlightsController < ApplicationController
  def home
    @airports = Airport.airports_by_geography
  end

  def index
    @flights = Flight.from_to(params[:origin], params[:destination])
  end
end
