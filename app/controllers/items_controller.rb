class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def index
    @items = Item.includes(:user).order('created_at DESC')
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    return unless @item.user_id != current_user.id || @item.order.present?

    redirect_to root_path
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(item_params)
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy if @item.user_id == current_user.id
    redirect_to root_path
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(
      :image, :name, :description, :category_id,
      :condition_id, :ship_area_id, :ship_date_id,
      :ship_method_id, :price
    ).merge(user_id: current_user.id)
  end
end
