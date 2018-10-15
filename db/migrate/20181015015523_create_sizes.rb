class CreateSizes < ActiveRecord::Migration[5.2]
  def change
    create_table :sizes do |t|
      t.integer :product_id
      t.integer :size_type
      t.integer :quantity

      t.timestamps
    end
  end
end
