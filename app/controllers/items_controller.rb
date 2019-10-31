class ItemsController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show, :more, :search, :search_more]
  before_action :puru
  before_action :set_item, only: [:show, :edit, :destroy]

  def index
    la_query = "select * from items join tradings on items.id = item_id where tradings.sale_state = 'exhibit' and category_index between 1 and 137 order by items.created_at desc limit 10"
    @ladies_items = Item.find_by_sql(la_query)
    la_item_id = Trading.where(id: @ladies_items.map{|a| a[:id]}).map{|a| a[:item_id]}
    @la_image = Image.where(item_id: la_item_id).order("created_at desc")

    me_query = "select * from items join tradings on items.id = item_id where tradings.sale_state = 'exhibit' and category_index between 138 and 258 order by items.created_at desc limit 10"
    @mens_items = Item.find_by_sql(me_query)
    me_item_id = Trading.where(id: @mens_items.map{|a| a[:id]}).map{|a| a[:item_id]}
    @me_image = Image.where(item_id: me_item_id).order("created_at desc")

    ma_query = "select * from items join tradings on items.id = item_id where tradings.sale_state = 'exhibit' and category_index between 781 and 866 order by items.created_at desc limit 10"
    @machine_items = Item.find_by_sql(ma_query)
    ma_item_id = Trading.where(id: @machine_items.map{|a| a[:id]}).map{|a| a[:item_id]}
    @ma_image = Image.where(item_id: ma_item_id).order("created_at desc")

    ho_query = "select * from items join tradings on items.id = item_id where tradings.sale_state = 'exhibit' and category_index between 576 and 682 order by items.created_at desc limit 10"
    @hobby_items = Item.find_by_sql(ho_query)
    ho_item_id = Trading.where(id: @hobby_items.map{|a| a[:id]}).map{|a| a[:item_id]}
    @ho_image = Image.where(item_id: ho_item_id).order("created_at desc")

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
    @image = Image.find_by(item_id: @item.id).url
    @delivery = Delivery.find_by(user_id: current_user.id)
    @card = CreditCard.find_by(user_id: current_user.id)

    Payjp.api_key = 'sk_test_f98999ddca480c61d3498ee7'
    customer = Payjp::Customer.retrieve(@card.customer_id,)
    @default_card_information = customer.cards.retrieve(@card.card_id)
  end

  def update
    @trading = Trading.find_by(item_id: "#{params[:id]}")
    if @trading.sale_state == "trade"
      @trading.update(sale_state: "sold")
      redirect_to "/users/#{current_user.id}/trade_after"
    end
  end


  def show
    @category_gc= Category.find(@item[:category_index])
    @category_c = @category_gc.parent
    @category = @category_c.parent
    @trading = Trading.find_by(item_id: params[:id])
    @user = User.find(@trading.saler_id)
    @good = Good.where(item_id: params[:id])
    @image = Image.find_by(item_id: params[:id]).url

    category_id = Category.where("ancestry like ?", "#{@category.id}/%")
    @item_list = Item.where(category_index: category_id).limit(6).order("created_at desc").where.not(id: params[:id])
    item_id = @item_list.map{|dd| dd[:id]}
    @trade_list = Trading.where(item_id: item_id).order("created_at desc")
    @image_list = Image.where(item_id: item_id).order("created_at desc")

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
    @category_array = ["---"]
    Category.where(ancestry: nil).each do |parent|
      @category_array << parent.name
    end

    @item.images.build(url: item_params[:url])
    if @item.save
      redirect_to new_after_path
    else
      render action: :new
    end
  end

  def destroy
    @item.destroy
    redirect_to "/users/#{current_user.id}/delete_after"
  end

  def edit
    @user = User.find(current_user.id)

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
    @category_array = ["---"]
    Category.where(ancestry: nil).each do |parent|
      @category_array << parent.name
    end

    if @item.save
      redirect_to "/users/#{current_user.id}"
    else
      render action: :edit
    end
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
      @item_list = Item.where(category_index: category_id).order("created_at desc")

    elsif (@category_gc[:ancestry].match("\/"))       #第3世代を引いたとき
      @category_gc = Category.find(params[:id])
      @category_c = @category_gc.parent
      @parent = @category_c.parent
      @item_list = Item.where(category_index: @category_gc).order("created_at desc")

    elsif (@category_gc.children != nil) && (@category_gc.parent != nil)   #第2世代を引いた時
      @category_c = @category_gc
      @parent = @category_gc.parent
      @category_gc = nil
      @items = Item.where(category_index: @category_c)
      @category_list = @category_c.children
      category_id = @category_list.map{|i| i.id}
      @item_list = Item.where(category_index: category_id).order("created_at desc")
    end

    item_id = @item_list.map{|dd| dd[:id]}
    @trade = Trading.where(item_id: item_id).order("created_at desc")
    @image = Image.where(item_id: item_id).order("created_at desc")

  end

  def category_children
    @category_children = Category.find_by(name: "#{params[:parent_name]}", ancestry: nil).children
  end

  def category_grandchildren
    @category_grandchildren = Category.find("#{params[:child_id]}").children
  end


  def puru
    @parents = Category.where(ancestry: nil)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def search
    if params[:search].length != 0
      @items = Item.where(' item_name LIKE(?) or description LIKE(?)', "%#{params[:search]}%", "%#{params[:search]}%").order("created_at desc")
      @images = Image.where(item_id: @items.map{|i| i.id}).order("created_at desc")
      @trade = Trading.where(item_id: @items.map{|i| i.id}).order("created_at desc")
    else
      redirect_to root_path
    end
    @q = Item.ransack(params[:q])
    @item = @q.result(distinct: true)
  end

  def search_more
    @item_name = params[:q][:item_name_cont]
    @q = Item.ransack(params[:q])
    @items = @q.result(distinct: true).order("created_at desc")
    @images = Image.where(item_id: @items.map{|i| i.id}).order("created_at desc")
    @trade = Trading.where(item_id: @items.map{|i| i.id}).order("created_at desc")
  end

  private

  def item_params
    params.require(:item).permit(:item_name, :description, :price, :state, :size, :fee_size, :region, :delivery_date, :category_index, :url, :item_name_cont)
  end

end


