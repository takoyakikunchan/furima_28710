class Address < ApplicationRecord
  validates :postal_code, :prefecture_id, :city, :street, :phone_number, presence: true
  validates :phone_number, { format: { with: /\A[0-9]{11}+\z/ }, length: { maximum: 11 } }
  validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'はハイフン(-)を入力してください' }
# ジャンルの選択が「--」の時は保存できないようにする
validates :prefecture_id, numericality: { other_than: 1 , message: 'を選択してください' }

  belongs_to :order, optional: true
  belongs_to :user, optional: true

end
