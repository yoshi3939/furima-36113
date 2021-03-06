class Item < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  has_one :record

  with_options presence: true do
    validates :image
    validates :name
    validates :description
  end

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :item_status
  belongs_to :delivery_charge
  belongs_to :prefecture
  belongs_to :delivery_days

  validates :category_id, :item_status_id, :delivery_charge_id, :prefecture_id, :delivery_days_id,
            numericality: { other_than: 0, message: 'を選択してください' }
  validates :price, format: { with: /\A[0-9]+\z/, message: 'は半角数字のみ入力してください' },
                    numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, message: 'は300~9,999,999の範囲で入力してください' }
end
