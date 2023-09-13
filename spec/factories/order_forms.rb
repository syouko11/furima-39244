FactoryBot.define do
  factory :order_form do
    postal_code   { "#{Faker::Number.number(digits: 3)}-#{Faker::Number.number(digits: 4)}" }
    prefecture_id { Faker::Number.within(range: 1..47) }
    city          { Gimei.city.kanji }
    address       { "#{Gimei.town.kanji}#{Faker::Number.number(digits: 3)}" }
    building      { Faker::Address.building_number }
    phone_number  { Faker::Number.leading_zero_number(digits: 11) }
    token         { "tok_abcdefghijk00000000000000000" }
  end
end
