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

  def self.find_oauth(auth) # omniauthのコールバック時に呼ばれるメソッド
    uid = auth.uid
    provider = auth.provider
    snscredential = SnsCredential.find_by(uid: uid, provider: provider)

    if snscredential.present? #sns登録のみ完了してるユーザー
      user = User.find_by(id: snscredential.user_id)
      unless user.present? #ユーザーが存在しないなら
        password = Devise.friendly_token[0, 8]#パスワード生成
        user = User.new(
          # snsの情報を取ってくる
          name: auth.info.name,
          email: auth.info.email,
          password: password,
          password_confirmation: password
          )

        end
    sns = snscredential

    else #sns登録 未 の場合
      user = User.find_by(email: auth.info.email)
      if user.present? #会員登録 済 の場合
        sns = SnsCredential.new(
          uid: uid,
          provider: provider,
          user_id: user.id
          )
        else #会員登録 未 の場合
          password = Devise.friendly_token[0, 8]#パスワードを生成(hidden_fieldに入力)
        user = User.new(
          name: auth.info.name,
          email: auth.info.email,
          password: password,
          password_confirmation: password
        )
        sns = SnsCredential.create(
          uid: uid,
          provider: provider
        )
      end
    end
    # hashでsnsのidを返り値として保持しておく
    return { user: user , sns_id: sns.id }
  end

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name,presence: true, length: {maximum: 20}
  validates :email,presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  validates :password,presence: true
  validates :last_name,presence: true
  validates :first_name,presence: true
  validates :last_name_kana,presence: true
  validates :first_name_kana,presence: true
  validates :birthday, presence: true
  validates :tel_number, presence: true

end