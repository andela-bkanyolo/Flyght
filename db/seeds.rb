require "csv"

CSV.foreach("#{Rails.root}/lib/seeds/airports.csv", :headers => true,
  header_converters: :symbol) do |row|
  Airport.create(row.to_hash)
end

CSV.foreach("#{Rails.root}/lib/seeds/airlines.csv", :headers => true,
  header_converters: :symbol) do |row|
  Airline.create(row.to_hash)
end

CSV.foreach("#{Rails.root}/lib/seeds/flights.csv", :headers => true,
  header_converters: :symbol) do |row|
  airline = Airline.find_by code: row[:airline]
  row.delete(6)
  airline.flights.create(row.to_hash)
end
