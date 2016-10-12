class Airport < ApplicationRecord
  validates :code, :presence => true, :uniqueness => true
  validates :name, :city, :country, :latitude,
    :longitude, :tax, :presence => true
end
