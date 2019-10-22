class ItemsController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show, :more]
  before_action :puru

  def index
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

  def destroy
    @item = Item.find_by(id: params[:id])
    @item.destroy
    redirect_to "/users/#{current_user.id}/delete_after"
  end

  def edit
    @user = User.find(current_user.id)
    @item = Item.find(params[:id])

    @category_array = ["---"]
    Category.where(ancestry: nil).each do |parent|
      @category_array << parent.name
    end
  end

  def edit_update
    @item = Item.find(params[:item_id])
    @item.update(item_name: item_params[:item_name], description: item_params[:description],
                price: item_params[:price], state: item_params[:state],
                size:item_params[:size], fee_size: item_params[:fee_size],
                region: item_params[:region],
                delivery_date: item_params[:delivery_date],
                category_index: item_params[:category_index])
    # redirect_to root_path
    redirect_to "/users/#{current_user.id}"
    # ここ↑今はマイページに飛ぶが後で訂正する。「変更しました」を挟むか、商品編集ページに飛ぶようにする。
  end


  def more
    @category_gc = Category.find(params[:id])
    @category_c = nil
    @parent = nil

    if (@category_gc[:ancestry] == nil)       #第1世代を引いた時
      @parent = @category_gc
      @category_c = nil
      @category_gc = nil
      category_id = Category.where("ancestry like ?", "#{@parent.id}/%")
      @category_list = @parent.children
      @item_list = Item.where(category_index: category_id)

    elsif (@category_gc[:ancestry].match("\/"))       #第3世代を引いたとき
      @category_gc = Category.find(params[:id])
      @category_c = @category_gc.parent
      @parent = @category_c.parent
      @item_list = Item.where(category_index: @category_gc)

    elsif (@category_gc.children != nil) && (@category_gc.parent != nil)   #第2世代を引いた時
      @category_c = @category_gc
      @parent = @category_gc.parent
      @category_gc = nil
      @items = Item.where(category_index: @category_c)
      @category_list = @category_c.children
      category_id = @category_list.map{|i| i.id}
      @item_list = Item.where(category_index: category_id)
    end

    item_id = @item_list.map{|dd| dd[:id]}
    @trade = Trading.where(item_id: item_id)

  end

  def puru
    # [1,138,259,387,517,576,683,781,867,976,1027,1086,1146]
    @parent_list = Category.where(ancestry: nil)
  end

  def drop_child
    @drop_children = Category.find_by(ancestry: "#{params[:parent]}").children
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

end


