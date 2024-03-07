class PurchaseHistoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :non_purchased_item, only: [:index, :create]

  def index
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @purchase_history_form = PurchaseHistoryForm.new
  end

  def create
    @purchase_history_form = PurchaseHistoryForm.new(purchase_history_params)
    @item = Item.find(params[:item_id]) # 商品情報を取得
    @ship_method = @item.ship_method # 商品に関連する配送方法を取得
    if @purchase_history_form.valid?
      pay_item
      @purchase_history_form.save
      redirect_to root_path
    else
      gon.public_key = ENV['PAYJP_PUBLIC_KEY']
      render 'index', status: :unprocessable_entity
    end
  end

  private

  def purchase_history_params
    params.require(:purchase_history_form).permit(:postal_code, :ship_area_id, :city, :street, :building_name, :phone_number).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price, # 商品の値段
      card: purchase_history_params[:token], # カードトークン
      currency: 'jpy' # 通貨の種類（日本円）
    )
  end

  def non_purchased_item
    @item = Item.find(params[:item_id])
    redirect_to root_path if current_user.id == @item.user_id || @item.purchase_history.present?
  end

end