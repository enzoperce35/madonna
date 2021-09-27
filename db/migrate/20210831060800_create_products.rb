class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :name
      t.float :price
      t.integer :multiplier, default: 0
      t.string :category

      t.timestamps
    end
  end
end
