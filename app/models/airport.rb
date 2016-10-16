class Airport < ApplicationRecord
  validates :code, :presence => true, :uniqueness => true
  validates :name, :city, :country, :latitude,
    :longitude, :tax, :presence => true

  def formatted
    "#{country} - #{city} - #{name} (#{code})"
  end
end
