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

  def exhibiting
    @user = User.find(current_user.id)
    @trading = Trading.where(saler_id: current_user.id).order("created_at DESC")

    # @item = Item.where(id: @trading) 
  end

end
