class CreateDeliveries < ActiveRecord::Migration[5.2]
  def change
    create_table :deliveries do |t|
      t.references :user, foreign_key: true, null: false
      t.string :first_name
      t.string :last_name
      t.string :first_name_kana
      t.string :last_name_kana
      t.integer :postal_code
      t.string :area
      t.string :city
      t.string :address
      t.string :building
      t.timestamps
    end
  end
end
