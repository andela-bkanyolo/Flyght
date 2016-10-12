class Airline < ApplicationRecord
  has_many :routes
  validates :code, :presence => true, :uniqueness => true
  validates :name, :country, :fee, :presence => true
end
