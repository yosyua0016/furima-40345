class ItemsController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]
  before_action :authenticate_user!, only: [:new, :edit, :destroy]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :move_to_index, only: [:edit, :update]

  def index
  end
end
