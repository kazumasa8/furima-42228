class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :category_id, :condition_id, :shipping_fee_id, :prefecture_id,
                                 :scheduled_id, :price, :image).merge(user_id: current_user.id)
  end
end
