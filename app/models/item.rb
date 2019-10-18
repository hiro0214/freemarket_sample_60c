class Item < ApplicationRecord

  has_one :trading

  validates :item_name, presence: true, length: { maximum: 40 }
  validates :description, presence: true, length:{maximum: 1000 , message: "must be given please" }
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to:300 }
  validates :price, numericality: { only_integer: true, less_than:9999999 } 
  # validates :state, presence: true,exclusion:{ in: %w(---) }
  validates :state, presence: true
  validates :fee_size, presence: true
  validates :region, presence: true
  validates :delivery_date, presence: true
end
