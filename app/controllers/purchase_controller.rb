class PurchaseController < ApplicationController

  require 'payjp'

  def index
    card = CreditCard.where(user_id: current_user.id).first
    #Cardテーブルは前回記事で作成、テーブルからpayjpの顧客IDを検索
    if card.blank?
      #登録された情報がない場合にカード登録画面に移動
      redirect_to controller: "card", action: "new"
    else
      Payjp.api_key = 'sk_test_f98999ddca480c61d3498ee7'
      # Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      #本来は保管した顧客IDでpayjpから情報取得
      customer = Payjp::Customer.retrieve(card.customer_id)
      #保管したカードIDでpayjpから情報取得、カード情報表示のためインスタンス変数に代入
      @default_card_information = customer.cards.retrieve(card.card_id)
    end
  end

  def pay
    card = CreditCard.where(user_id: current_user.id).first
    Payjp.api_key = 'sk_test_f98999ddca480c61d3498ee7'
    Payjp::Charge.create(
    :amount => 100, #テストの為、直接支払金額を入力（itemテーブル等に紐づけても良い）
    :customer => card.customer_id, #顧客ID
    :currency => 'jpy', #日本円
  )
  redirect_to action: 'done' #完了画面に移動
  end

end