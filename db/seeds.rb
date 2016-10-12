# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
File.open("#{Rails.root}/public/seed/airports.dat") do |airports|
  airports.read.each_line do |airport|
    id, nam, cit, countr, iata, icao, lat, longt, alt, tz, dst, tzd = airport.chomp.split(",")
    #  to remove the quotes from the text:
    iata.gsub!(/\A"|"\Z/, '')
    nam.gsub!(/\A"|"\Z/, '')
    cit.gsub!(/\A"|"\Z/, '')
    countr.gsub!(/\A"|"\Z/, '')
    tz.gsub!(/\A"|"\Z/, '')
    # to create each record in the database
    Airport.create({ code: iata, name: nam, city:  cit, country: countr,
      latitude: lat, longitude: longt, timezone: tz, tax: Random.rand(10)})
  end
end

File.open("#{Rails.root}/public/seed/airlines.dat") do |airlines|
  airlines.read.each_line do |airline|
    id, nam, alia, iata, icao, calsign, countr, actv = airline.chomp.split(",")
    #  to remove the quotes from the text:
    iata.gsub!(/\A"|"\Z/, '')
    nam.gsub!(/\A"|"\Z/, '')
    countr.gsub!(/\A"|"\Z/, '')
    # to create each record in the database
    Airline.create({ code: iata, name: nam, country: countr, fee: Random.rand(10)})
  end
end

File.open("#{Rails.root}/public/seed/routes.dat") do |routes|
  routes.read.each_line do |route|
    iata, aid, source, sid, dest, destid, codesh, stops, eqpt = route.chomp.split(",")
    #  to remove the quotes from the text:
    iata.gsub!(/\A"|"\Z/, '')
    source.gsub!(/\A"|"\Z/, '')
    dest.gsub!(/\A"|"\Z/, '')
    # to create each record in the database
    a = Airline.find_by code: iata
    o = Airport.find_by code: source
    d = Airport.find_by code: dest
    a.routes.create({ origin: source, destination: dest }) if (a && o && d)
  end
end
