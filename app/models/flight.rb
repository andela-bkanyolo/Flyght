class Flight < ApplicationRecord
  validates :ref, :departure, :arrival, :price, :presence => true
  belongs_to :route
end
