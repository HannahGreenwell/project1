class RemoveProductIdFromLineItems < ActiveRecord::Migration[5.2]
  def change
    remove_column :line_items, :product_id, :integer
  end
end
