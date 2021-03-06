require 'rails_helper'

RSpec.describe RecordDeliveryAddress, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @record_delivery_address = FactoryBot.build(:record_delivery_address, user_id: user.id, item_id: item.id)
    sleep 0.1
  end

  describe '商品購入機能' do
    context '商品購入情報がデータベースへ保存されるとき' do
      it 'postal_code, prefecture_id, city, house_number, building_name, phone_number, tokenが存在すれば登録できる' do
        expect(@record_delivery_address).to be_valid
      end
      it 'postal_codeの値が「3桁ハイフン4桁」の半角文字列であれば登録できる' do
        @record_delivery_address.postal_code = '123-4567'
        expect(@record_delivery_address).to be_valid
      end
      it 'phone_numberの値が、10桁以上11桁以内の半角数値であれば登録できる' do
        @record_delivery_address.phone_number = '09012345678'
        expect(@record_delivery_address).to be_valid
      end
      it 'building_nameが空でも登録できる' do
        @record_delivery_address.building_name = ''
        expect(@record_delivery_address).to be_valid
      end
    end

    context '商品購入情報がデータベースへ保存されないとき' do
      it 'postal_codeが空だと登録できない' do
        @record_delivery_address.postal_code = ''
        @record_delivery_address.valid?
        expect(@record_delivery_address.errors.full_messages).to include("郵便番号を入力してください")
      end
      it 'postal_codeにハイフンがないと登録できない' do
        @record_delivery_address.postal_code = '1111111'
        @record_delivery_address.valid?
        expect(@record_delivery_address.errors.full_messages).to include('郵便番号はハイフンを入れて正しく入力してください')
      end
      it 'postal_codeが全角文字だと登録できない' do
        @record_delivery_address.postal_code = '１１１-１１１１'
        @record_delivery_address.valid?
        expect(@record_delivery_address.errors.full_messages).to include('郵便番号はハイフンを入れて正しく入力してください')
      end
      it 'postal_codeが「3桁ハイフン3桁」であると登録できない' do
        @record_delivery_address.postal_code = '111-111'
        @record_delivery_address.valid?
        expect(@record_delivery_address.errors.full_messages).to include('郵便番号はハイフンを入れて正しく入力してください')
      end
      it 'prefectureが空だと登録できない' do
        @record_delivery_address.prefecture_id = 0
        @record_delivery_address.valid?
        expect(@record_delivery_address.errors.full_messages).to include('都道府県を選択してください')
      end
      it 'cityが空だと登録できない' do
        @record_delivery_address.city = ''
        @record_delivery_address.valid?
        expect(@record_delivery_address.errors.full_messages).to include("市区町村を入力してください")
      end
      it 'house_numberが空だと登録できない' do
        @record_delivery_address.house_number = ''
        @record_delivery_address.valid?
        expect(@record_delivery_address.errors.full_messages).to include("番地を入力してください")
      end
      it 'phone_numberが空だと登録できない' do
        @record_delivery_address.phone_number = ''
        @record_delivery_address.valid?
        expect(@record_delivery_address.errors.full_messages).to include("電話番号を入力してください")
      end
      it 'phone_numberにハイフンがあると登録できない' do
        @record_delivery_address.phone_number = '090-1234-5678'
        @record_delivery_address.valid?
        expect(@record_delivery_address.errors.full_messages).to include('電話番号は数字のみ入力してください')
      end
      it 'phone_numberが9桁であると登録できない' do
        @record_delivery_address.phone_number = '090123456'
        @record_delivery_address.valid?
        expect(@record_delivery_address.errors.full_messages).to include('電話番号は数字のみ入力してください')
      end
      it 'phone_numberが12桁であると登録できない' do
        @record_delivery_address.phone_number = '090123456789'
        @record_delivery_address.valid?
        expect(@record_delivery_address.errors.full_messages).to include('電話番号は数字のみ入力してください')
      end
      it 'ユーザー情報がない場合は登録できない' do
        @record_delivery_address.user_id = nil
        @record_delivery_address.valid?
        expect(@record_delivery_address.errors.full_messages).to include("Userを入力してください")
      end
      it '商品情報がない場合は登録できない' do
        @record_delivery_address.item_id = nil
        @record_delivery_address.valid?
        expect(@record_delivery_address.errors.full_messages).to include("Itemを入力してください")
      end
      it 'tokenが空だと登録できない' do
        @record_delivery_address.token = nil
        @record_delivery_address.valid?
        expect(@record_delivery_address.errors.full_messages).to include("クレジットカード情報を入力してください")
      end
    end
  end
end
