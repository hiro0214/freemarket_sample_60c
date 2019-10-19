require 'rails_helper'

describe Item do
  describe '#create' do

    # itemテーブルのitem_nameが空だと登録できないかのテスト。
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

    it "商品名が40文字以下だと登録できるか " do
      item = build(:item, item_name: "aaaaaa")
      expect(item).to be_valid
    end


  end
end
