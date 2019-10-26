class AddDeliveryIdToTradings < ActiveRecord::Migration[5.2]
  def change
    add_reference :tradings, :deliveries, null: false
  end
end
