class Booking < ApplicationRecord
  include BookingsHelper

  belongs_to :flight
  belongs_to :user
  has_many :passengers, inverse_of: :booking,
                        dependent: :destroy
  accepts_nested_attributes_for :passengers, allow_destroy: true
  validates :reference, :price, :departure, presence: true
  validates :email,
            presence: true,
            length: { maximum: 255 },
            format: { with: VALID_EMAIL }
  before_validation :generate_reference, :set_price, on: :create
  before_create :generate_reference, :set_price

  def generate_reference
    self.reference =
      "#{SecureRandom.hex(3)}/#{flight.id}/#{flight.number}".upcase
  end

  def set_price
    self.price = total_booking_cost(flight, passengers.size)
  end
end
