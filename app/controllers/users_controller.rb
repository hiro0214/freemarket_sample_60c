class UsersController < ApplicationController

  def show
    @user = User.find(current_user.id)
  end

  def profile
    @user = User.find(current_user.id)
  end

  def logout
    @user = User.find(current_user.id)
  end

  def identification
    @user = User.find(current_user.id)
  end

  def exhibiting
    @user = User.find(current_user.id)
    tradings = Trading.where(saler_id: current_user.id, sale_state: "exhibit")
    trading = tradings.map {|t| t[:item_id]}
    @items = Item.where(id: trading)
  end

  def edit_item
    @user = User.find(current_user.id)
    @item = Item.find(params[:id])
  end

end
