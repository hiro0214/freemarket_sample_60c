class RemoveColumnBuyDateToTradings < ActiveRecord::Migration[5.2]
  # Remove foreign key
  def change
    # remove_foreign_key :deliveries_id, :tradings
  end

end