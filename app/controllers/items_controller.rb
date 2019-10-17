class ItemsController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show, :more]

  def index
    # @items = Item.limit(10).order("created_at desc")
    query =  "select * from items where id in (select item_id from tradings where sale_state = 'exhibit') order by created_at desc limit 10"
    @items = Item.find_by_sql(query)
  end

  def edit
    @item = Item.find(params[:id])
    @trading = Trading.find_by(item_id: "#{params[:id]}")
    @user = User.find(current_user.id)
  end

  def update
    @trading = Trading.find_by(item_id: "#{params[:id]}")
    if @trading.sale_state == "exhibit"
      @trading.update(sale_state: "trade", buyer_id: current_user.id)
      redirect_to edit_after_path
    else
      redirect_to root_path
      # エラーメッセージを出したい
    end
  end

  def show
    @item = Item.find(params[:id])
    @trading = Trading.find_by(item_id: params[:id])
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


  def more
    query = "select * from items join tradings on items.id = item_id order by tradings.created_at desc"
    @items = Item.find_by_sql(query)
  end

  private

  def item_params
    params.require(:item).permit(:item_name, :description, :price, :state, :fee_size, :region, :delivery_date)
  end

end


