class FlightsController < ApplicationController
  before_action :get_airports

  def home
  end

  def index
    origin = params[:origin]
    destination = params[:destination]
    date = params[:date]
    @passengers = params[:passengers].to_i
    @flights = []

    begin
      date = Time.parse(date)
      if date < Time.now
        flash.now[:time] = "Date cannot be earlier than current date."
      elsif date > Time.now + 1.year
        flash.now[:time] = "Date cannot be later than one year from today."
      else
        @flights = gen_flights(origin, destination, date).sort_by! { |f| f.price }
      end
    rescue ArgumentError
      flash.now[:time] = "Invalid date entered."
    end

    if origin == destination
      flash.now[:airports] = "Origin and Destination airport cannot be the same."
    end

    if @flights.empty? && !flash[:time] && !flash[:airports]
      flash.now[:flights] = "No flights available for this route.
        Try selecting a different origin and/or destination."
    end

    respond_to do |format|
      format.js   {}
    end
  end

  private

  def get_airports
    @airports = Airport.order(country: :asc,
      city: :asc, name: :asc, code: :asc)
  end

  def gen_flights(from, to, date)
    routes = Route.where ({ origin: from, destination: to })
    routes.map do |route|
      departure = random_time(date)
      arrival = departure + route.duration.hours
      ref = route.airline.code + route.id.to_s
      route.flights.create({ ref: ref, departure: departure,
        arrival: arrival, price: calculate_price(route) })
    end
  end

  def random_time(time)
    hour = rand(0..23)
    minute = rand(0..59)
    Time.parse("#{hour}:#{minute}", time)
  end

  def calculate_price(route)
    base_fee = (route.airline.fee / 10) * route.distance
    tax_origin = route.origin_airport.tax / 100
    tax_dest = route.destination_airport.tax / 100
    tax = (tax_origin * base_fee) + (tax_dest * base_fee)
    (base_fee + tax).round(2)
  end

  def flight_params
    params.require().permit()
  end
end
