class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :shipping_fee_person
  belongs_to_active_hash :region
  belongs_to_active_hash :date_ish
  #空の投稿を保存できないようにする
  validates :name, :image,:price,:description,:category,:condition,:shipping_fee_person,:region,:date_ish, presence: true

  #ジャンルの選択が「--」の時は保存できないようにする
  validates :category_id,:condition_id,:shipping_fee_person_id,:region_id,:date_ish_id, numericality: { other_than: 1 } 
  validates :name, length: { maximum: 40 }
  validates :description,length: { maximum: 1000 }
end
