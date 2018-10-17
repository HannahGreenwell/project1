class RemoveAddressFromOrders < ActiveRecord::Migration[5.2]
  def change
    remove_column :orders, :address, :text
  end
end
