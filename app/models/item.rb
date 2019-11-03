class Item < ApplicationRecord

  has_one :trading, dependent: :destroy
  has_one :categories
  has_many :images, dependent: :destroy
  has_many :goods, dependent: :destroy

  def good_user(user_id)
    goods.find_by(user_id: user_id)
  end

  validates :item_name, presence: true, length: { in: 1..40 }
  validates :description, presence: true, length:{maximum: 1000 , message: "must be given please" }
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to:300, less_than:9999999 }
  validates :category_index,presence:true
  validates :state, presence: true
  validates :fee_size, presence: true
  validates :region, presence: true
  validates :delivery_date, presence: true
  validates :category_index, exclusion: { in: %w(---) }

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
end
