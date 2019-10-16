class ItemsController < ApplicationController

  before_action :move_to_index, except: [:index, :show]

  def index
    @items = Item.limit(10).order("created_at desc")
    # @trading = Trading.where.not(sale_state: "exhibit")
  end

  def edit
    @item = Item.find(params[:id])
    @trading = Trading.find_by(item_id: "#{params[:id]}")
  end

  def update
    @trading = Trading.find_by(item_id: "#{params[:id]}")
    if @trading.sale_state == "exhibit"
      @trading.update(sale_state: "trade", buyer_id: current_user.id)
    else
      redirect_to root_path
      # エラーメッセージを出したい
    end
  end

  def show
    @item = Item.find(params[:id])
  end


  def exhibit
    @item = Item.new
  end


  def create
    @item = Item.new(item_name: item_params[:item_name],
                description: item_params[:description],
                price: item_params[:price],
                state: item_params[:state],
                fee_size: item_params[:fee_size],
                region: item_params[:region],
                delivery_date: item_params[:delivery_date])
    @item.build_trading(saler_id: current_user.id)
    if @item.save
      redirect_to exhibit_after_path
    end
  end



  private

  def item_params
    params.require(:item).permit(:item_name, :description, :price, :state, :fee_size, :region, :delivery_date)
  end

  def move_to_index
    redirect_to new_user_session_path unless user_signed_in?
  end

end


