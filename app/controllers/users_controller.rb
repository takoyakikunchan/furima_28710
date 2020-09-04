class UsersController < ApplicationController
 def show
  Payjp.api_key = ENV["PAYJP_SECRET_KEY"] # 環境変数を読み込む
card = Card.find_by(user_id: current_user.id) # ユーザーのid情報を元に、カード情報を取得
   if card.present?
     customer = Payjp::Customer.retrieve(card.customer_token) # 先程のカード情報を元に、顧客情報を取得
     @card = customer.cards.first
   end
  end
 def update
  # binding.pry
  if current_user.update!(user_params) # 更新出来たかを条件分岐する
    sign_in(current_user, :bypass => true)
    redirect_to root_path # 更新できたらrootパスへ
   else
    redirect_to "show" # 失敗すればマイページへ
   end
 end

 private

 def user_params
  params.require(:user).permit(:nickname, :email,:password) # 編集出来る情報を制限
end

end
