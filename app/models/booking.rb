class Booking < ApplicationRecord
  include BookingsHelper

  belongs_to :flight
  has_many :passengers, inverse_of: :booking
  accepts_nested_attributes_for :passengers
  #validates :reference, :price, :presence => true
  VALID_EMAIL = /\A[\w+\-.]+@[a-z\d\.]+[\w+]\.[a-z]+\z/i
  validates :email,
            presence: true,
            length: { maximum: 255 },
            format: { with: VALID_EMAIL }
  #before_validate :set_price
  before_create :generate_reference, :set_price

  def generate_reference
    # flight = Flight.find_by id: flight_id
    self.reference = "#{SecureRandom.hex(3)}/#{flight.id}/#{flight.ref}".upcase
  end

  def set_price
    self.price = total_booking_cost(flight, passengers.size)
  end
end
