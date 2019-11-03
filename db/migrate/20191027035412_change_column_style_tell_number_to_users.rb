class ChangeColumnStyleTellNumberToUsers < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :tel_number, :string
  end
end
