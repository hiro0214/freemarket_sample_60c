class ItemsController < ApplicationController

  def index
    @items = Item.limit(10).order("created_at desc")
  end

  def show
    @item = Item.find(params[:id])
  end

end


