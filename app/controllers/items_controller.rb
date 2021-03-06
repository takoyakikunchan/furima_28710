class ItemsController < ApplicationController
  before_action :move_to_login, only: [:new]
  before_action :set_item, only: [:show, :destroy, :edit, :update]
  def index
    @items = Item.all.includes(:user).order(id: 'DESC')
  end

  def new
    @item = ItemsTag.new
  end

  def create
    @item_tag = ItemsTag.new(item_params)
    @item = @item_tag.save
  end

  def show
    @comment = Comment.new
    @comments = @item.comments.includes(:user)
  end

  def destroy
    if @item.destroy
      redirect_to items_path
    else
      render :show
    end
  end

  def edit
    @item = Item.find(params[:id])
    @tag = @item.tags 
  end

  def update
    item = ItemsTag.new(item_update_params)
    if item.image == nil
      item.image = @item.image.blob
    end
    if item.valid?
       item.update
      @item = Item.find(params[:id])
      @comment = Comment.new
      @comments = @item.comments.includes(:user)
      render :show
    else
      @item = Item.find(params[:id])
      @tag = @item.tags 
      render :edit
    end
  end

  def search
    return nil if params[:input] == ""
     tag = Tag.where(['tag_name LIKE ?', "%#{params[:input]}%"] )
     render json:{ keyword: tag }
  end

  def item_search
    @items = Item.item_search(params[:keyword])
    @keyword = params[:keyword]
    if @items== nil
      redirect_to root_path
    end
  end


def hashtag
  @tag = Tag.find(params[:tag_id])
  @items = @tag.items
end

  def move_to_login
    redirect_to new_user_session_path unless user_signed_in?
  end

  private

  # Create
  def item_params 
    params.require(:items_tag).permit(:tag_name, :name, :image, :description, :price, :category_id, :condition_id, :shipping_fee_person_id, :region_id, :date_ish_id).merge(user_id: current_user.id)
  end

  # Update
  def item_update_params
    params.require(:item).permit(:tag_name, :name, :image, :description, :price, :category_id, :condition_id, :shipping_fee_person_id, :region_id, :date_ish_id).merge(user_id: current_user.id, item_id: params[:id])
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
