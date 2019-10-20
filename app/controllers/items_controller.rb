class ItemsController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show, :more]
  before_action :puru

  def index
    # tradings = Trading.where(sale_state: "exhibit")
    # trading = tradings.map {|t| t[:item_id]}
    # @items = Item.limit(10).order("created_at desc").where(id: trading)
    # query =  "select * from items where id in (select item_id from tradings where sale_state = 'exhibit') order by created_at desc limit 10"
    # @items = Item.find_by_sql(query)

    la_query = "select * from items join tradings on items.id = item_id where tradings.sale_state = 'exhibit' and category_index between 1 and 137 order by items.created_at desc limit 10"
    @ladies_items = Item.find_by_sql(la_query)
    me_query = "select * from items join tradings on items.id = item_id where tradings.sale_state = 'exhibit' and category_index between 138 and 258 order by items.created_at desc limit 10"
    @mens_items = Item.find_by_sql(me_query)
    ma_query = "select * from items join tradings on items.id = item_id where tradings.sale_state = 'exhibit' and category_index between 781 and 866 order by items.created_at desc limit 10"
    @machine_items = Item.find_by_sql(ma_query)
    ho_query = "select * from items join tradings on items.id = item_id where tradings.sale_state = 'exhibit' and category_index between 576 and 682 order by items.created_at desc limit 10"
    @hobby_items = Item.find_by_sql(ho_query)

  end

  def new
    @item = Item.new
    @category_array = ["---"]
    Category.where(ancestry: nil).each do |parent|
      @category_array << parent.name
    end
  end

  def buy
    @user = User.find(current_user.id)
    @item = Item.find(params[:item_id])
    @trading = Trading.find_by(item_id: "#{params[:item_id]}")
  end

  def update
    @trading = Trading.find_by(item_id: "#{params[:id]}")
    if @trading.sale_state == "exhibit"
      @trading.update(sale_state: "trade", buyer_id: current_user.id)
      redirect_to buy_after_path
    else
      redirect_to root_path
      # エラーメッセージを出したい
    end
  end

  def show
    @item = Item.find(params[:id])
    @category_gc= Category.find(@item[:category_index])
    @category_c = @category_gc.parent
    @category = @category_c.parent
    @trading = Trading.find_by(item_id: params[:id])
    @user = User.find(@trading.saler_id)
  end

  def create
    @item = Item.new(item_name: item_params[:item_name],
                description: item_params[:description],
                price: item_params[:price],
                state: item_params[:state],
                size: item_params[:size],
                fee_size: item_params[:fee_size],
                region: item_params[:region],
                delivery_date: item_params[:delivery_date],
                category_index: item_params[:category_index])
    @item.build_trading(saler_id: current_user.id)
    if @item.save
      redirect_to new_after_path
    else
      render action: :new
    end
  end


  def more
    query = "select * from items join tradings on items.id = item_id order by tradings.created_at desc"
    @items = Item.find_by_sql(query)
    @category = Category.find(params[:id])
  end


  def category_children
    @category_children = Category.find_by(name: "#{params[:parent_name]}", ancestry: nil).children
  end

  def category_grandchildren
    @category_grandchildren = Category.find("#{params[:child_id]}").children
  end

  private

  def item_params
    params.require(:item).permit(:item_name, :description, :price, :state, :size, :fee_size, :region, :delivery_date, :category_index)
  end

  def puru
    # @parents = Category.where(ancestry: nil)
    # @ladies_c = Category.where(ancestry: "1")
    # @ladies_gc = Category.where(ancestry: "1/2")
  end

end


