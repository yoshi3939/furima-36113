require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録がうまくいくとき' do
      it 'nicknameとemail、passwordとpassword_confirmation、last_nameとfirst_name、last_name_kanaとfirst_name_kana、birth_dateが存在すれば登録できる' do
        expect(@user).to be_valid
      end
      it 'passwordが6文字以上で、半角英数宇混合であれば登録できる' do
        @user.password = 'aaaa11'
        @user.password_confirmation = 'aaaa11'
        expect(@user).to be_valid
      end
    end

    context '新規登録がうまくいかないとき' do
      it 'nicknameが空だと登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("ニックネームを入力してください")
      end
      it 'emailが空だと登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("メールアドレスを入力してください")
      end
      it '重複したemailが存在する場合登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('メールアドレスはすでに存在します')
      end
      it 'emailは@がないと登録できない' do
        @user.email = 'aaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('メールアドレスは不正な値です')
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードを入力してください', 'パスワードは半角英数字のみ入力可です')
      end
      it 'passwordは、５文字以下であれば登録できない' do
        @user.password = 'aaa11'
        @user.password_confirmation = 'aaa11'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
      end
      it 'passwordは、半角数字のみでは登録できない' do
        @user.password = '111111'
        @user.password_confirmation = '111111'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは半角英数字のみ入力可です')
      end
      it 'passwordは、半角英字のみでは登録できない' do
        @user.password = 'aaaaaa'
        @user.password_confirmation = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは半角英数字のみ入力可です')
      end
      it 'passwordは、全角文字では登録できない' do
        @user.password = 'ａａａ１１１'
        @user.password_confirmation = 'ａａａ１１１'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは半角英数字のみ入力可です')
      end
      it 'passwordとpassword_confirmationは、値が一致しないと登録できない' do
        @user.password = 'aaa111'
        @user.password_confirmation = 'aaa112'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end
      it 'お名前(全角)は、last_nameが空だと登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字を入力してください", '苗字は全角のみ入力可です')
      end
      it 'お名前(全角)は、first_nameが空だと登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名前を入力してください", '名前は全角のみ入力可です')
      end
      it 'お名前(全角)は、last_nameが全角(漢字・ひらがな・カタカナ)でないと登録できない' do
        @user.last_name = 'yamada'
        @user.valid?
        expect(@user.errors.full_messages).to include('苗字は全角のみ入力可です')
      end
      it 'お名前(全角)は、first_nameが全角(漢字・ひらがな・カタカナ)でないと登録できない' do
        @user.first_name = 'taro'
        @user.valid?
        expect(@user.errors.full_messages).to include('名前は全角のみ入力可です')
      end
      it 'お名前カナ(全角)は、last_name_kanaが空だと登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字カナを入力してください", '苗字カナは全角カナのみ入力可です')
      end
      it 'お名前カナ(全角)は、first_name_kanaが空だと登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名前カナを入力してください", '名前カナは全角カナのみ入力可です')
      end
      it 'お名前カナ(全角)は、last_name_kanaが全角(カタカナ)でないと登録できない' do
        @user.last_name_kana = 'やまだ'
        @user.valid?
        expect(@user.errors.full_messages).to include('苗字カナは全角カナのみ入力可です')
      end
      it 'お名前カナ(全角)は、first_name_kanaが全角(カタカナ)でないと登録できない' do
        @user.first_name_kana = 'たろう'
        @user.valid?
        expect(@user.errors.full_messages).to include('名前カナは全角カナのみ入力可です')
      end
      it '生年月日が空だと登録できない' do
        @user.birth_date = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("誕生日を入力してください")
      end
    end
  end
end
