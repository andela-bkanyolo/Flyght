class Passenger < ApplicationRecord
  validates :name, :passport, presence: true
  belongs_to :booking, inverse_of: :passengers
  validates_presence_of :booking
  validates :age,
            presence: true,
            numericality: { greater_than_or_equal_to: 0,
            only_integer: true }
end
