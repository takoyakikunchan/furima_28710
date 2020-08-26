class OrdersController < ApplicationController
  
  def index
    @item =Item.find(params[:item_id]) 
    @order = OrderAddress.new
  end

  def create
    @order = OrderAddress.new(order_params)
    if @order.valid?
      pay_item
      @order.save
      return redirect_to root_path
    else
      render 'index'
    end
  end

  private

  def order_params 
    params.permit(:token,:postal_code, :prefecture_id,:city, :street, :building,:phone_number ).merge(user_id: current_user.id,item_id: params[:item_id])
  end

  def pay_item
    @item =Item.find(params[:item_id]) 
    Payjp.api_key = "sk_test_06fd50ec2a67d681c0444536"  # PAY.JPテスト秘密鍵
    Payjp::Charge.create(
      amount: @item.price,  # 商品の値段
      card: order_params[:token],    # カードトークン
      currency:'jpy'                 # 通貨の種類(日本円)
    )
  end
end
