class CreateProductSizes < ActiveRecord::Migration[5.2]
  def change
    create_table :product_sizes do |t|
      t.integer :product_id
      t.integer :size
      t.integer :quantity

      t.timestamps
    end
  end
end
