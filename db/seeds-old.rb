require "csv"

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

#allowed = CSV.read("#{Rails.root}/lib/seeds/airlines.csv").map {|row| row[0]}
File.open("#{Rails.root}/public/seed/airlines.dat") do |airlines|
  airlines.read.each_line do |airline|
    id, nam, alia, iata, icao, calsign, countr, actv = airline.chomp.split(",")
    #  to remove the quotes from the text:
    iata.gsub!(/\A"|"\Z/, '')
    nam.gsub!(/\A"|"\Z/, '')
    countr.gsub!(/\A"|"\Z/, '')
    # to create each record in the database
 #   if allowed.include? iata
      Airline.create({ code: iata, name: nam, country: countr, fee: Random.rand(1..10)})
  #  end
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

    hour = rand(0..23)
    minute = rand(0..59)
    time = Time.parse("#{hour}:#{minute}")

    dist = Geocoder::Calculations.distance_between([o.latitude, o.longitude],
      [d.latitude, d.longitude], :units => :km) if (o && d)
    duration = dist / 600 if dist

    if dist && a && o && d
      base_fee = (a.fee / 10) * dist
      tax_origin = o.tax / 100
      tax_dest = d.tax / 100
      tax = (tax_origin * base_fee) + (tax_dest * base_fee)
      price = (base_fee + tax).round(2)

      a.flights.create({ origin: source, destination: dest,
      departure: time, distance: dist, duration: duration, price: price })
    end
  end
end

column_headers = ["code", "name", "city", "country", "latitude", "longitude"]
CSV.open("#{Rails.root}/lib/seeds/airports.csv", "wb", write_headers: true, headers: column_headers) do |csv|
  Airport.all.each do |a|
    csv << [a.code, a.name, a.city, a.country, a.latitude, a.longitude]
  end
end

column_headers = ["code", "name", "country"]
CSV.open("#{Rails.root}/lib/seeds/airlines.csv", "wb", write_headers: true, headers: column_headers) do |csv|
  Airline.all.each do |a|
    csv << [a.code, a.name, a.country] unless a.flights.empty?
  end
end

column_headers = ["origin", "destination", "departure", "distance", "duration", "price", "airline_id"]
CSV.open("#{Rails.root}/lib/seeds/flights.csv", "wb", write_headers: true, headers: column_headers) do |csv|
  Flight.all.each do |f|
    csv << [f.origin, f.destination, f.departure,
      f.distance, f.duration, f.price, f.airline.code]
  end
end
