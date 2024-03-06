class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :edit, :create]
  before_action :set_item, only: [:show, :edit, :update]
  before_action :move_to_index, only: [:edit, :update]


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
    redirect_to root_path unless current_user == @item.user
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  #def destroy
   # @item.destroy if @item.user_id == current_user.id
    #redirect_to root_path
  #end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def move_to_index
    redirect_to root_path unless current_user.id == @item.user_id
  end

  def item_params
    params.require(:item).permit(
      :image, :name, :description, :category_id,
      :condition_id, :ship_area_id, :ship_date_id,
      :ship_method_id, :price
    ).merge(user_id: current_user.id)
  end
end