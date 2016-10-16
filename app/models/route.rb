class Route < ApplicationRecord
  attr_reader :origin_airport, :destination_airport

  validates :origin, :destination, :distance, :presence => true
  belongs_to :airline
  has_many :flights

  def origin_airport
    Airport.find_by code: origin
  end

  def destination_airport
    Airport.find_by code: destination
  end

end
