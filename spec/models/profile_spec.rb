require 'rails_helper'
describe User do
  before do
    @profile = FactoryBot.build(:profile)
  end

  describe 'ユーザー新規登録' do
    context '新規登録がうまくいくとき' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@profile).to be_valid
      end
    end
  end
end
