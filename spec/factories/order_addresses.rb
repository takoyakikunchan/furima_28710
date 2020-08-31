FactoryBot.define do
  factory :order_address do
    postal_code { '123-4567' }
    prefecture_id { 2 }
    city { '東京都' }
    street { '1-1' }
    building { '東京ハイツ' }
    phone_number { '09099999999' }
  end
end
