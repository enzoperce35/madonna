class CreateInventoryItems < ActiveRecord::Migration[6.1]
  def change
    create_table :inventory_items do |t|
      t.string :name
      t.string :unit
      t.float :current_stock
      t.float :remaining_stock
      t.string :item_type

      t.timestamps
    end
  end
end
