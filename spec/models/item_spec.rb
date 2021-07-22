require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能' do
    context '商品情報がデータベースへ保存されるとき' do
      it 'nameとdescription, imageとcategory_id, item_status_idとdelivery_charge_id, prefecture_idとdelivery_days_id,priceが存在すれば登録できる' do
        expect(@item).to be_valid
      end
      it 'priceの値が300~9999999の間で、半角数値であれば登録できる' do
        @item.price = '5000'
        expect(@item).to be_valid
      end
    end

    context '商品情報がデータベースへ保存されないとき' do
      it 'nameが空だと登録できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it 'descriptionが空だと登録できない' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end
      it 'categoryが空だと登録できない' do
        @item.category_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end
      it 'item_statusが空だと登録できない' do
        @item.item_status_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Item status can't be blank")
      end
      it 'delivery_chargeが空だと登録できない' do
        @item.delivery_charge_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery charge can't be blank")
      end
      it 'prefectureが空だと登録できない' do
        @item.prefecture_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'delivery_daysが空だと登録できない' do
        @item.delivery_days_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery days can't be blank")
      end
      it 'priceが300未満だと登録できない' do
        @item.price = '299'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is out of setting range')
      end
      it 'priceが9999999より大きいと登録できない' do
        @item.price = '10000000'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is out of setting range')
      end
      it 'priceが全角数字だと登録できない' do
        @item.price = '５００'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is out of setting range')
      end
    end
  end
end
