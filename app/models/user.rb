class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable,
          :omniauthable,
          omniauth_providers: %i[facebook google_oauth2]

  has_many :sns_credentials, dependent: :destroy
  has_one :credit_card
  has_one :delivery

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture

  # omniauthのコールバック時に呼ばれるメソッド

  def self.find_oauth(auth)
    uid = auth.uid
    provider = auth.provider
    # snscredential = SnsCredential.where(uid: uid, provider: provider).first
    snscredential = SnsCredential.find_by(uid: uid, provider: provider)
    # binding.pry

    if snscredential.present? #sns登録のみ完了してるユーザー
      user = User.find_by(id: snscredential.user_id)
      # binding.pry
      unless user.present? #ユーザーが存在しないなら
        password = Devise.friendly_token[0, 8]#パスワード生成
        user = User.new(
          # snsの情報を取ってくる
          name: auth.info.name,
          email: auth.info.email,
          password: password,
          password_confirmation: password
          )

          # return { user: user , sns_id: sns.id }
          # binding.pry
    end
    sns = snscredential

    else #sns登録 未
      user = User.find_by(email: auth.info.email)
      if user.present? #会員登録 済
        sns = SnsCredential.new(
          uid: uid,
          provider: provider,
          user_id: user.id
          )
        else #会員登録 未
          # binding.pry
          password = Devise.friendly_token[0, 8]#パスワード生成
        user = User.new(
          name: auth.info.name,
          email: auth.info.email,
          password: password,
          password_confirmation: password
        )
        # binding.pry
        sns = SnsCredential.create(
          uid: uid,
          provider: provider
        )
        # binding.pry
      end
    end
    # binding.pry
    # hashでsnsのidを返り値として保持しておく
    return { user: user , sns_id: sns.id }
  end
end
