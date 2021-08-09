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
        @item.price = 5000
        expect(@item).to be_valid
      end
    end

    context '商品情報がデータベースへ保存されないとき' do
      it 'nameが空だと登録できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品名を入力してください")
      end
      it 'descriptionが空だと登録できない' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の説明を入力してください")
      end
      it 'categoryが空だと登録できない' do
        @item.category_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("カテゴリーを選択してください")
      end
      it 'item_statusが空だと登録できない' do
        @item.item_status_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の状態を選択してください")
      end
      it 'delivery_chargeが空だと登録できない' do
        @item.delivery_charge_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("配送料の負担を選択してください")
      end
      it 'prefectureが空だと登録できない' do
        @item.prefecture_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("発送元の地域を選択してください")
      end
      it 'delivery_daysが空だと登録できない' do
        @item.delivery_days_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("発送までの日数を選択してください")
      end
      it 'priceが空だと登録できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格は半角数字のみ入力してください',
                                                      '販売価格は300~9,999,999の範囲で入力してください')
      end
      it 'priceが300未満だと登録できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格は300~9,999,999の範囲で入力してください')
      end
      it 'priceが9999999より大きいと登録できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格は300~9,999,999の範囲で入力してください')
      end
      it 'priceが全角数字だと登録できない' do
        @item.price = '５００'
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格は300~9,999,999の範囲で入力してください')
      end
      it 'ユーザー情報がない場合は登録できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('Userを入力してください')
      end
    end
  end
end
