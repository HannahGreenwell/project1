class AddProductSizeIdToLineItems < ActiveRecord::Migration[5.2]
  def change
    add_column :line_items, :product_size_id, :integer
  end
end
