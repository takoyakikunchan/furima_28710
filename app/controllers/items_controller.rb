class ItemsController < ApplicationController
  before_action :move_to_login, only: [:new]

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
    @item = Item.find(params[:id])
  end

  def move_to_login
    redirect_to new_user_session_path unless user_signed_in?
  end

  private

  def item_params
    params.require(:item).permit(:name, :image, :description, :price, :category_id, :condition_id, :shipping_fee_person_id, :region_id, :date_ish_id).merge(user_id: current_user.id)
  end
end
