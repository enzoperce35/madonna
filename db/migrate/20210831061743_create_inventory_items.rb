class CreateInventoryItems < ActiveRecord::Migration[6.1]
  def change
    create_table :inventory_items do |t|
      t.string :name
      t.string :unit
      t.float :current_stock
      t.float :subtractive
      t.float :additional
      t.float :remaining_stock
      t.string :type

      t.timestamps
    end
  end
end
