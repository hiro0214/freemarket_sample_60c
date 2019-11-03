class AddGoodsCountToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :goods_count, :integer
  end
end
