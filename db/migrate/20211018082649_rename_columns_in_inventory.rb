class RenameColumnsInInventory < ActiveRecord::Migration[6.1]
  def change
    rename_column :inventory_items, :current_stock, :maximum_stock
    add_column :inventory_items, :margin, :float, default: 1.0
  end
end
