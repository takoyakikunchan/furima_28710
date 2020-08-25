class ItemsController < ApplicationController
  before_action :move_to_login, only: [:new]
  before_action :set_item, only: [:show, :destroy, :edit, :update]
  def index
    @items = Item.all.includes(:user).order(id: 'DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def destroy
    if @item.destroy
      redirect_to root_path
    else
      render :show
    end
  end

  def edit
  end

  def update
    if @item.update(item_params)
      render :show
    else
      render :edit
    end
  end

  def move_to_login
    redirect_to new_user_session_path unless user_signed_in?
  end

  private

  def item_params
    params.require(:item).permit(:name, :image, :description, :price, :category_id, :condition_id, :shipping_fee_person_id, :region_id, :date_ish_id).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
