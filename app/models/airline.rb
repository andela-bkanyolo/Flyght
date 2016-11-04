class Airline < ApplicationRecord
  has_many :flights
  validates :code, presence: true,
                   uniqueness: true
  validates :name, :country, presence: true
end
