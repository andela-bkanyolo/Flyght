class Booking < ApplicationRecord
  belongs_to :flight
  has_many :passengers, inverse_of: :booking
  accepts_nested_attributes_for :passengers
  validates :reference, :presence => true
  VALID_EMAIL = /\A[\w+\-.]+@[a-z\d\.]+[\w+]\.[a-z]+\z/i
  validates :email,
            presence: true,
            length: { maximum: 255 },
            format: { with: VALID_EMAIL }
end
