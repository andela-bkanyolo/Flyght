class FlightsController < ApplicationController
  def index
    @airports = Airport.order(country: :asc,
      city: :asc, name: :asc, code: :asc)
  end
end
