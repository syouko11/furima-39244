FactoryBot.define do
  factory :item do
    name { Faker::Name.name }
    introduction { Faker::Lorem.sentence }
    category_id { Faker::Number.within(range: 1..10) }
    sales_status_id { Faker::Number.within(range: 1..6) }
    shopping_cost_id { Faker::Number.within(range: 1..2) }
    prefecture_id { Faker::Number.within(range: 1..47) }
    shopping_date_id { Faker::Number.within(range: 1..3) }
    price { Faker::Number.within(range: 300..9_999_999) }

    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
