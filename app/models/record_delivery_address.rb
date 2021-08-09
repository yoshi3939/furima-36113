class RecordDeliveryAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :city, :house_number, :building_name, :phone_number, :token

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'はハイフンを入れて正しく入力してください' }
    validates :prefecture_id, numericality: { other_than: 0, message: 'を選択してください' }
    validates :city
    validates :house_number
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'は数字のみ入力してください' }
    validates :token
  end

  def save
    record = Record.create(user_id: user_id, item_id: item_id)
    DeliveryAddress.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, house_number: house_number,
                           building_name: building_name, phone_number: phone_number, record_id: record.id)
  end
end
