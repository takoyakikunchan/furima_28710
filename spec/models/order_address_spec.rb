require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  describe '購入情報の保存' do
    before do
      @order_address = FactoryBot.build(:order_address)
    end

    it 'すべての値が正しく入力されていれば保存できること' do
      expect(@order_address).to be_valid
    end
    it 'buildingは空でも保存できること' do
      @order_address.building = ''
      expect(@order_address).to be_valid
    end
    it '郵便番号が空だと保存できないこと' do
      @order_address.postal_code = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("郵便番号を入力してください")
    end
    it '郵便番号が半角のハイフンを含んだ正しい形式でないと保存できないこと' do
      @order_address.postal_code = '1234567'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('郵便番号はハイフン(-)を入力してください')
    end
    it '都道府県が空だと保存できないこと' do
      @order_address.prefecture_id = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("都道府県を入力してください")
    end
    it '市区町村が空だと保存できないこと' do
      @order_address.city = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("市区町村を入力してください")
    end
    it '番地が空だと保存できないこと' do
      @order_address.street = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("番地を入力してください")
    end
    it '電話番号が空だと保存できないこと' do
      @order_address.phone_number = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("電話番号を入力してください")
    end
    it '電話番号にはハイフンは不要で、11桁以内でないと保存できないこと' do
      @order_address.phone_number = '090-9999-8888'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('電話番号は不正な値です', '電話番号は11文字以内で入力してください')
    end
  end
end
