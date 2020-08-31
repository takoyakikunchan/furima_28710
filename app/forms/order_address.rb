class OrderAddress
  include ActiveModel::Model
  attr_accessor :token, :postal_code, :prefecture_id, :city, :street, :building, :phone_number, :item_id, :user_id

  validates :postal_code, :prefecture_id, :city, :street, :phone_number, presence: true
  validates :phone_number, { format: { with: /\A[0-9]{11}+\z/ }, length: { maximum: 11 } }
  validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'はハイフン(-)を入力してください' }
# ジャンルの選択が「--」の時は保存できないようにする
validates :prefecture_id, numericality: { other_than: 1 , message: 'を選択してください' }
  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    # 住所の情報を保存
    Address.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, street: street, building: building, order_id: order.id, phone_number: phone_number)
  end
end
