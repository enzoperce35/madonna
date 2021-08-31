class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :name
      t.float :price
      t.integer :multiplier
      t.integer :sales

      t.timestamps
    end
  end
end
