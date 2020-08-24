FactoryBot.define do 
  factory :item do 
    name { 'キャラクター図鑑' }
    description { '講談社 未使用' } 
    category_id { 3 } 
    condition_id { 2 } 
    shipping_fee_person_id { 2 } 
    date_ish_id { 2 } 
    region_id { 3 } 
    price { 2000 } 
    association :user
  end 
end 
