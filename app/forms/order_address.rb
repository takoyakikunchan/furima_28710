class OrderAddress

  include ActiveModel::Model
  attr_accessor   :token,:postal_code, :prefecture_id, :city, :street, :building,:phone_number,:item_id,:user_id

  def save
    order = Order.create(user_id:user_id,item_id:item_id)
    # 住所の情報を保存
    Address.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, street: street, building: building,order_id: order.id,phone_number: phone_number)
  end

end