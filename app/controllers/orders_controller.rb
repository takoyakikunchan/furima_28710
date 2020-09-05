class OrdersController < ApplicationController
  before_action :move_to_index, only: [:index]

  def index
    @item = Item.find(params[:item_id])
    @order = Order.new
    @address = current_user.addresses.first
  end

  def create
    @address = current_user.addresses.first
    @item = Item.find(params[:item_id])
    @order = Order.new(order_params)
    if @order.valid?
      pay_item
      @order.save
      @address.update(order_id: @order.id)
      redirect_to root_path
    else
      render 'index'
    end
  end

  private
  def order_params
    params.permit(:order).merge(user_id: current_user.id, item_id: params[:item_id])
  end

  def pay_item
    @item = Item.find(params[:item_id])
    
    if current_user.card.present?
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"] # 環境変数を読み込む
      customer_token = current_user.card.customer_token # ログインしているユーザーの顧客トークンを定義
      Payjp::Charge.create(
        amount: @item.price, # 商品の値段
        customer: customer_token, # 顧客のトークン
        currency: 'jpy' # 通貨の種類（日本円）
        )
    else
     Payjp.api_key = ENV['PAYJP_SECRET_KEY'] # PAY.JPテスト秘密鍵
    Payjp::Charge.create(
      amount: @item.price, # 商品の値段
      card: params[:token], # カードトークン
      currency: 'jpy'                 # 通貨の種類(日本円)
    )
    end
  end

  def move_to_index
    @item = Item.find(params[:item_id])
    if !user_signed_in?
      redirect_to new_user_session_path
    elsif current_user.id == @item.user_id || !@item.order.nil?
      redirect_to root_path
    end
  end
end
