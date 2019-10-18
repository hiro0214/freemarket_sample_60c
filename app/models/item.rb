class Item < ApplicationRecord
  has_one :trading
  belongs_to :category
end
