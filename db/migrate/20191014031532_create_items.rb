class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :item_name, null: false
      t.text :description, null: false
      t.integer :price, null: false
      t.string :state, null: false
      t.string :size
      t.string :fee_size, null: false
      t.string :region, null: false
      t.string :delivery_date, null: false
      t.timestamps
    end
  end
end
