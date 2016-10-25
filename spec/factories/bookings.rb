FactoryGirl.define do
  factory :booking do
    reference { Faker::Code.asin }
    email Faker::Internet.email
    price Faker::Number.positive
    departure Faker::Date.forward(23)
    flight
  end
end
