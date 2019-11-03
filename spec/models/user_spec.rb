require 'rails_helper'

describe User do
  describe '#create' do

    it "ニックネームが空だと登録できないか" do
      user = build(:user, name: "")
      user.valid?
      expect(user.errors[:name]).to include("can't be blank")
    end

    it "メールアドレスが空だと登録できないか" do
      user = build(:user, email: "")
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

    it "first_nameが空だと登録できないか" do
      user = build(:user, first_name: "")
      user.valid?
      expect(user.errors[:first_name]).to include("can't be blank")
    end

    it "last_nameが空だと登録できないか" do
      user = build(:user, last_name: "")
      user.valid?
      expect(user.errors[:last_name]).to include("can't be blank")
    end

    it "生年月日が空だと登録できないか" do
      user = build(:user, birthday: "")
      user.valid?
      expect(user.errors[:birthday]).to include("can't be blank")
    end

    it "電話番号が空だと登録できないか" do
      user = build(:user, tel_number: "")
      user.valid?
      expect(user.errors[:tel_number]).to include("can't be blank")
    end

    it "重複したemailが存在する場合登録できないか" do
      user = create(:user)
      another_user = build(:user, email: user.email)
      another_user.valid?
      expect(another_user.errors[:email]).to include("has already been taken")
    end

    it "重複したニックネームが存在する場合登録できないか" do
      user = create(:user)
      another_user = build(:user, name: user.name)
      another_user.valid?
      expect(another_user.errors[:name]).to include("has already been taken")
    end
  end
end