class Flight < ApplicationRecord
  validates :ref, :departure, :arrival, :price, :presence => true
  belongs_to :route
  has_many :bookings
  attr_reader :description

  def description
    "#{price.round(2)} USD : #{ref} #{route.origin} - #{route.destination}
    #{route.airline.name} DEPARTURE: #{departure} ARRIVAL: #{arrival}"
  end
end
