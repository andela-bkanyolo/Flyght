# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
File.open("#{Rails.root}/public/seed/airports.csv") do |airports|
  airports.read.each_line do |airport|
    id,ident,type,nam,lat,longt,elevation_ft,
    cont,countr,iso_region,cit,scheduled_service,gps_code,
    iata,local_code,home_link,wikipedia_link,keywords = airport.chomp.split(",")

    type.gsub!(/\A"|"\Z/, '')
    cont.gsub!(/\A"|"\Z/, '')

    if type == "large_airport" && cont == "AF"
      #  to remove the quotes from the text:
      iata.gsub!(/\A"|"\Z/, '') if iata
      nam.gsub!(/\A"|"\Z/, '')
      cit.gsub!(/\A"|"\Z/, '')
      countr.gsub!(/\A"|"\Z/, '')
      lat.gsub!(/\A"|"\Z/, '')
      longt.gsub!(/\A"|"\Z/, '')
      countr.gsub!(/\A"|"\Z/, '')

      Airport.create({ code: iata, name: nam, city:  cit, country: countr,
      latitude: lat, longitude: longt, tax: Random.rand(1..20)})
    end
  end
end

File.open("#{Rails.root}/public/seed/iso_country.csv") do |isos|
  isos.read.each_line do |iso|
    nam, cod = iso.chomp.split(",")
    #  to remove the quotes from the text:
    nam.gsub!(/\A"|"\Z/, '')
    cod.gsub!(/\A"|"\Z/, '')

    Airport.where(country: cod).update_all(country: nam)
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
    Airline.create({ code: iata, name: nam, country: countr, fee: Random.rand(1..10)})
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

    dist = Geocoder::Calculations.distance_between([o.latitude, o.longitude],
      [d.latitude, d.longitude], :units => :km) if (o && d)
    time = dist / 600 if dist
    a.routes.create({ origin: source, destination: dest, distance: dist, duration: time }) if (a && o && d)
  end
end
