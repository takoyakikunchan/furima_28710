class ItemsController < ApplicationController
  def index
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

  private
  def item_params
    params.require(:item).permit(:name, :image,:description,:price,:category_id,:condition_id,:shipping_fee_person_id,:region_id,:date_ish_id)
  
  end

end
