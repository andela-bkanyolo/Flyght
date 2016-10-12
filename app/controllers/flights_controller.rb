class FlightsController < ApplicationController
  def index
    @airports = Airport.order(country: :asc,
      city: :asc, name: :asc, code: :asc)
    if
  end

  private

  def flight_params
    params.require().permit()
  end
end
