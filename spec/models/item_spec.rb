require 'rails_helper'
describe Item do
  before do
    @item = FactoryBot.build(:item)
    @item.image = fixture_file_upload('public/images/test_image.png')
  end

  describe '商品の保存' do
    context '商品が保存できる場合' do
      it '全ての値が正しく入力されてれば保存できる' do
        expect(@item).to be_valid
      end
    end
    context '商品が保存できない場合' do
      it '画像は1枚必須であること' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it '商品名の情報がないと保存できない' do
        @item.name = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it 'カテゴリーの情報がないと保存できない' do
        @item.category_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end
      it '商品の状態についての情報がないと保存できない' do
        @item.condition_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition can't be blank")
      end
      it '配送料の負担についての情報がないと保存できない' do
        @item.shipping_fee_person_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping fee person can't be blank")
      end
      it '発送元の地域についての情報がないと保存できない' do
        @item.region_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Region can't be blank")
      end
      it '発送までの日数についての情報がないと保存できない' do
        @item.date_ish_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Date ish can't be blank")
      end
      it '価格についての情報がないと保存できない' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it 'priceが300円未満では保存できないこと' do
        @item.price = 200
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is out of setting range')
      end
      it 'priceが9,999,999円を超過すると保存できないこと' do
        @item.price = 100_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is out of setting range')
      end
      it 'ユーザーが紐付いていないと商品は保存できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('User must exist')
      end
      it 'ジャンルの選択が「--」の時は商品は保存できない' do
        @item.date_ish_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Date ish must be other than 1')
      end

      it '商品名が40文字以上では保存できないこと' do
        @item.name = "a"*50
        @item.valid?
       expect(@item.errors.full_messages).to include("Name is too long (maximum is 40 characters)")
      end

      it '商品説明が1000文字以上では保存できないこと' do
        @item.description = "a"*10000
        @item.valid?
       expect(@item.errors.full_messages).to include("Description is too long (maximum is 1000 characters)")
      end







    end
  end
end
