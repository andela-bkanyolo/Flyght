class Flight < ApplicationRecord
  attr_reader :origin_airport, :destination_airport
  validates :origin, :destination, :departure, :distance, :duration,
    :price, :presence => true
  belongs_to :airline
  has_many :bookings

  def origin_airport
    Airport.find_by code: origin
  end

  def destination_airport
    Airport.find_by code: destination
  end

  def number
    airline.code + id.to_s
  end

  def departure_date(date)
    departure.change(year: date.year,
                     month: date.month,
                     day: date.day)
  end

  def arrival_date(date)
    departure_date(date) + duration.hours
  end

  def self.from_to(origin, destination)
    if destination == ""
      where(origin: origin).order(price: :asc)
    else
      where(origin: origin, destination: destination).order(price: :asc)
    end
  end
end
