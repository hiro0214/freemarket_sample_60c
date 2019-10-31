class GoodController < ApplicationController
  def create
    @good = Good.create(user_id: current_user.id, item_id: params[:item_id])
    @goods = Good.where(item_id: params[:item_id])
    @item = Item.find(params[:item_id])
  end

  def destroy
    good = Good.find_by(user_id: current_user.id, item_id: params[:item_id])
    good.destroy
    @goods = Good.where(item_id: params[:item_id])
    @item = Item.find(params[:item_id])
  end
end
