class CardsController < ApplicationController
  def new
  end
  def create
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"] 
    customer = Payjp::Customer.create(
    description: 'test', 
    card: params[:card_token] 
    )
    card = Card.new( # トークン化されたカード情報を保存する
      card_token: params[:card_token], # カードトークン
      customer_token: customer.id, # 顧客トークン
      user_id: current_user.id 
    )
    binding.pry
    if card.save
      redirect_to root_path
    else
      redirect_to "new" # カード登録画面
    end
  end
end
