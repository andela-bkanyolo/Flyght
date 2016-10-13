class Flight < ApplicationRecord
  validates :ref, :departure, :arrival, :price, :presence => true
  belongs_to :route
  has_many :bookings
  attr_reader :description, :details

  def self.generate_flights(from, to, date)
    from = Airport.find_by id: from
    to = Airport.find_by id: to
    routes = Route.where ({ origin: from.code, destination: to.code })
    routes.collect do |route|
      departure = random_time(date)
      arrival = departure + rand(2..20).hours
      Flight.create({ ref: generate_ref(route), departure: departure,
        arrival: arrival, price: calculate_price(route), route_id: route.id })
    end
  end

  def self.calculate_price(route)
    tax_from = route.origin_airport.tax
    tax_to = route.destination_airport.tax
    vat = 1.16
    (route.airline.fee + 2) * (tax_from + tax_to + 2) * vat
  end

  def self.generate_ref(route)
    route.airline.code + route.id.to_s
  end

  def self.random_time(time)
    hour = rand(0..23)
    minute = rand(0..59)
    Time.parse("#{hour}:#{minute}", time)
  end

  def description
    "#{price.round(2)} USD : #{ref} #{route.origin} - #{route.destination}
    #{route.airline.name} DEPARTURE: #{departure} ARRIVAL: #{arrival}"
  end
end
