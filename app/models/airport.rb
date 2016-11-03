class Airport < ApplicationRecord
  validates :code, presence: true, uniqueness: true
  validates :name, :city, :country, :latitude, :longitude, presence: true

  def formatted
    "#{country} - #{city} - #{name} (#{code})"
  end

  def self.airports_by_geography
    Airport.order(country: :asc, city: :asc, name: :asc, code: :asc)
  end
end
