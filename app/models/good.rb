class Good < ApplicationRecord
  belongs_to :item, counter_cache: :goods_count
  belongs_to :user
end
