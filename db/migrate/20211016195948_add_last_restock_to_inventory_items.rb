class AddLastRestockToInventoryItems < ActiveRecord::Migration[6.1]
  def change
    add_column :inventory_items, :last_restock, :timestamp
  end
end
