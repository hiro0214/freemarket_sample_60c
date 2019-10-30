class PurchaseController < ApplicationController

  require 'payjp'

  def index
    # @item = Item.find(params[:item_id])
    # @trading = Trading.find_by(item_id: "#{params[:item_id]}")

    card = CreditCard.where(user_id: current_user.id).first  #テーブルからpayjpの顧客IDを検索しレコードをゲット

    if card.blank?  #登録された情報がない場合にカード登録画面に移動
      redirect_to controller: "CreditCard", action: "new"
    else
      Payjp.api_key = 'sk_test_f98999ddca480c61d3498ee7'  # 環境変数使用時→Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(card.customer_id)  #保管したカードIDでpayjpから情報取得、カード情報表示のためインスタンス変数に代入
      @default_card_information = customer.cards.retrieve(card.card_id)
    end
  end

  def pay
    @item = Item.find(params[:format])
    @delivery = Delivery.find_by(user_id: current_user.id)
    @trading = Trading.find_by(item_id: @item.id)

    if @trading[:buyer_id] == nil

      card = CreditCard.where(user_id: current_user.id).first
      Payjp.api_key = 'sk_test_f98999ddca480c61d3498ee7'
      Payjp::Charge.create(
      amount: @item.price, #支払金額（テスト時は直接金額の記入も可能）ここに今のアイテム情報
      customer: card.customer_id, #顧客ID
      currency: 'jpy' #為替を日本円に指定
    )

      @trading.update(
        sale_state: "trade",
        buyer_id: current_user.id,
        buy_date: Time.now,
        deliveries_id: @delivery.id,
      )

      redirect_to buy_after_path  #完了画面に移動

    else
      redirect_to root_path, flash: {buy_alert: "購入出来ませんでした"}
    end
  end

end