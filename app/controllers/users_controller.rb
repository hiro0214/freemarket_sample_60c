class UsersController < ApplicationController

  before_action :puru
  before_action :set_user

  def show
  end

  def profile
  end

  def logout
  end

  def identification
  end

  def exhibiting
    @user = User.find(current_user.id)
    tradings = Trading.where(saler_id: current_user.id, sale_state: "exhibit")
    trading = tradings.map {|t| t[:item_id]}#item_idを元に変数tradings(tradingsテーブルのレコードから指定したカラム)の情報をゲット
    @items = Item.where(id: trading)
  end

  def edit_item
    @item = Item.find(params[:id])
    @category_gc= Category.find(@item[:category_index])
    @category_c = @category_gc.parent
    @category = @category_c.parent
    # @trading = Trading.find_by(item_id: params[:id])
    # @user = User.find(@trading.saler_id)
    @image = Image.find_by(item_id: @item.id).url
  end

  def delete_after
  end

  def puru
    @parents = Category.where(ancestry: nil)
  end

  def set_user
    @user = User.find(current_user.id)
  end

end
