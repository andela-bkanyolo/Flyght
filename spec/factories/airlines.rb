FactoryGirl.define do
  factory :airline do
    code  { Faker::Code.asin }
    name Faker::Company.name
    country Faker::Address.country
  end
end
