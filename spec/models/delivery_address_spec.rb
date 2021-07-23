require 'rails_helper'

RSpec.describe DeliveryAddress, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能' do
    context '商品情報がデータベースへ保存されるとき' do
      it 'nameとdescription, imageとcategory_id, item_status_idとdelivery_charge_id, prefecture_idとdelivery_days_id,priceが存在すれば登録できる' do
        expect(@item).to be_valid
      end
      it 'priceの値が300~9999999の間で、半角数値であれば登録できる' do
        @item.price = 5000
        expect(@item).to be_valid
      end
    end

    context '商品情報がデータベースへ保存されないとき' do
      it 'nameが空だと登録できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
    end
  end
end