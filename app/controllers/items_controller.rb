class ItemsController < ApplicationController
  def index # indexアクションを定義した
    @items = Item.all
  end
end
