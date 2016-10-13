class Passenger < ApplicationRecord
  validates :name, :age, :passport, :presence => true
  belongs_to :booking
end
