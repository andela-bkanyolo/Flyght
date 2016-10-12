class Airport < ApplicationRecord
  has_many :flights
  validates :code, :presence => true, :uniqueness => true
  validates :name, :city, :country, :latitude,
    :longitude, :tax, :presence => true
end
