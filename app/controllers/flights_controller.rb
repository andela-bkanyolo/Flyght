class FlightsController < ApplicationController
  before_action :get_airports, only: [:home]

  def home
  end

  def index
    origin = params[:origin]
    destination = params[:destination]
    passengers = params[:passengers]
    date = params[:date]
    @search = FlightSearch.new(origin, destination, passengers, date)
    respond_to do |format|
      format.js {}
    end
  end

  private

  def get_airports
    @airports = Airport.order(country: :asc,
      city: :asc, name: :asc, code: :asc)
  end
end
