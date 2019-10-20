class AddCategoryIndexToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :category_index, :string
  end
end
