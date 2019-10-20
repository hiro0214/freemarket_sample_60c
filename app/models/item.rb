class Item < ApplicationRecord

  has_one :trading, dependent: :destroy
  has_one :categories

  validates :item_name, presence: true, length: { maximum: 40 }
  validates :description, presence: true, length:{maximum: 1000 , message: "must be given please" }
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to:300 }
  validates :price, numericality: { only_integer: true, less_than:9999999 }
  validates :state, presence: true
  validates :state, presence: true
  validates :fee_size, presence: true
  validates :region, presence: true
  validates :delivery_date, presence: true

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  # 上記の２行は、prefectureモデルを使用するための記述、
  # 関連付けたいテーブルに対応するモデルに記入

end
