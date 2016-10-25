FactoryGirl.define do
  factory :airport do
    code { Faker::Code.asin }
    name Faker::Company.name
    city Faker::Address.city
    country Faker::Address.country
    latitude Faker::Address.latitude
    longitude Faker::Address.longitude
  end
end
