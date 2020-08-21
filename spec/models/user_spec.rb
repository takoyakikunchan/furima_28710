require 'rails_helper'
describe User do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録がうまくいくとき' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@user).to be_valid
      end
      it 'passwordが6文字以上の半角英数混合であれば登録できる' do
        @user.password = 'knbn0000'
        @user.password_confirmation = 'knbn0000'
        expect(@user).to be_valid
      end
    end

    context '新規登録がうまくいかないとき' do
      it 'nicknameが空だと登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it '重複したemailが存在する場合登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordが5文字以下であれば登録できない' do
        @user.password = 'kn00'
        @user.password_confirmation = 'kn00'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'passwordが存在してもpassword_confirmationが空では登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'メールアドレスは@を含まないと登録できない' do
        @user.email = 'kkkkkkkk'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'パスワードは英語だけだと登録できない' do
        @user.password = 'kkkkkkkk'
        @user.password_confirmation = 'kkkkkkkk'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end
      it 'パスワードは数字だけだと登録できない' do
        @user.password = '00000000'
        @user.password_confirmation = '00000000'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end

      it 'ユーザー本名の名字が空だと登録できない' do
        @user.family_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name can't be blank", 'Family name is invalid')
      end
      it 'ユーザー本名の名前が空だと登録できない' do
        @user.given_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Given name can't be blank", 'Given name is invalid')
      end
      it 'ユーザー本名の名字は全角（漢字・ひらがな・カタカナ）以外だと登録できない' do
        @user.family_name = 'aaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Family name is invalid')
      end
      it 'ユーザー本名の名前は全角（漢字・ひらがな・カタカナ）以外だと登録できない' do
        @user.given_name = 'aaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Given name is invalid')
      end

      it 'ユーザー本名フリガナの名字が空だと登録できない' do
        @user.read_fam_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Read fam name can't be blank", 'Read fam name is invalid')
      end

      it 'ユーザー本名フリガナの名前が空だと登録できない' do
        @user.read_given_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Read given name can't be blank", 'Read given name is invalid')
      end

      it 'ユーザー本名フリガナは、カタカナ以外だと登録できない' do
        @user.read_given_name = '相原'
        @user.valid?
        expect(@user.errors.full_messages).to include('Read given name is invalid')
      end

      it '生年月日が空だと登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end
