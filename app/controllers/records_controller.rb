class RecordsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :set_item, only: [:index, :create]
  before_action :confirm_current_user, only: [:index, :create]
  before_action :sold_out, only: [:index, :create]

  def index
    @record_delivery_address = RecordDeliveryAddress.new
  end

  def create
    @record_delivery_address = RecordDeliveryAddress.new(record_params)
    if @record_delivery_address.valid?
      pay_item
      @record_delivery_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def record_params
    params.require(:record_delivery_address).permit(:user_id, :item_id, :postal_code, :prefecture_id, :city, :house_number, :building_name, :phone_number, :record_id).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def confirm_current_user
    redirect_to root_path if current_user.id == @item.user_id
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: record_params[:token],
      currency: 'jpy'
    )
  end

  def sold_out
    redirect_to root_path if @item.record.present?
  end
end
