class UsersController < ApplicationController

  def show
    @nickname = current_user.nickname
  #   # @items = current_user.id.order("created_at DESC")
  #   @item = Item.where(user_id:current_user.id)
  end

end
