FactoryGirl.define do
  factory :passenger do
    name Faker::Name.name
    age Faker::Number.between(1, 100)
    passport Faker::Code.asin
    phone Faker::PhoneNumber.phone_number
    booking
  end
end
