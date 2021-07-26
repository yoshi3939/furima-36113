FactoryBot.define do
  factory :record_delivery_address do
    postal_code { '111-1111' }
    prefecture_id { Faker::Number.between(from: 1, to: 48) }
    city { '中央区' }
    house_number { '月島' }
    building_name { '1-1' }
    phone_number { '09012345678' }
    association :user
    association :item
    token { 'tok_abcdefghijk00000000000000000' }
  end
end
