class RecordsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :set_item, only: [:index, :create]
  before_action :confirm_current_user, only: [:index, :create]

  def index
    @record_delivery_address = RecordDeliveryAddress.new
    @item = Item.find(params[:item_id])
  end

  def create
    @item = Item.find(params[:item_id])
    @record_delivery_address = RecordDeliveryAddress.new(record_params)
    if @record_delivery_address.valid?
      @record_delivery_address.save
      redirect_to root_path
    else
      render :index
    end

  end

  private

  def record_params
    params.require(:record_delivery_address).permit(:user_id, :item_id, :postal_code, :prefecture_id, :city, :house_number, :building_name, :phone_number, :record_id).merge(user_id: current_user.id, item_id: params[:item_id])
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def confirm_current_user
    if current_user.id == @item.user_id
      redirect_to root_path
    end
  end

end
