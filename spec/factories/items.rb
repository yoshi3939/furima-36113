FactoryBot.define do
  factory :item do
    name  { Faker::Name.name }
    description { Faker::Lorem.sentence }
    category_id { '1' }
    item_status_id { '1' }
    delivery_charge_id { '1' }
    prefecture_id { '1' }
    delivery_days_id { '1' }
    price { '500' }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
