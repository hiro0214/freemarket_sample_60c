class ItemsController < ApplicationController

  def index
    @items = Item.find(1)
    
  end

  def detail
    @items = Item.find(1)
  end

end


