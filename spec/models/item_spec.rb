require 'rails_helper'

describe Item do
  describe '#create' do

    it "商品名が空だと登録できないか" do
      item = build(:item, item_name: "")
      item.valid?
      expect(item.errors[:item_name]).to include("can't be blank")
    end

    it "商品の説明が空だと登録できないか" do
      item = build(:item, description: "")
      item.valid?
      expect(item.errors[:description]).to include("can't be blank")
    end

    it "商品名が40文字以上だと登録できないか " do
      item = build(:item, item_name: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa")
      item.valid?
      expect(item.errors[:item_name][0]).to include("is too long")
    end

    it "金額が10000000円以上だと登録できないか " do
      user = build(:item, price: "15000000")
      expect(:item => '15000000').to include(:item => '15000000')
    end

    it " 金額が299円以下だと登録できないか " do
      item = build(:item, price: "")
      expect(:item => '300').to include(:item => '300')
    end

    it "カテゴリーが空だと登録できないか" do
      item = build(:item,category_index: "")
      item.valid?
      expect(item.errors[:category_index]).to include("can't be blank")
    end

    it "商品の状態が空だと登録できないか" do
      item = build(:item,state: "")
      item.valid?
      expect(item.errors[:state]).to include("can't be blank")
    end

    it "配送料の負担が空だと登録できないか" do
      item = build(:item,fee_size: "")
      item.valid?
      expect(item.errors[:fee_size]).to include("can't be blank")
    end

    it "都道府県が空だと登録できないか" do
      item = build(:item,region: "")
      item.valid?
      expect(item.errors[:region]).to include("can't be blank")
    end

    it "発送までの日数が空だと登録できないか" do
      item = build(:item,delivery_date: "")
      item.valid?
      expect(item.errors[:delivery_date]).to include("can't be blank")
    end
  end
end
