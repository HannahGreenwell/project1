class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.text :name
      t.text :description
      t.text :brand
      t.money :price

      t.timestamps
    end
  end
end
