class ChangeColumnDeliveriesIdToTradings < ActiveRecord::Migration[5.2]
  def up
    change_column :tradings, :deliveries_id, :integer, null: true
  end
end
