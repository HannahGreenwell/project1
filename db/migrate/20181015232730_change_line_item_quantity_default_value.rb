class ChangeLineItemQuantityDefaultValue < ActiveRecord::Migration[5.2]
  def change
    change_column :line_items, :quantity, :integer, :default => 0
  end
end
