class CreateTradings < ActiveRecord::Migration[5.2]
  def change
    create_table :tradings do |t|
      t.references :item, foreign_key: true
      t.integer :saler_id
      t.integer :buyer_id
      t.string :sale_state, default: "exhibit"
      t.timestamps

      #delivery あとで追加

    end
  end
end