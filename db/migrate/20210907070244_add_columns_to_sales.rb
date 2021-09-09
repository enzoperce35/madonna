class AddColumnsToSales < ActiveRecord::Migration[6.1]
  def change
    add_column :sales, :product_id, :integer
    add_column :sales, :product_ids, :text, array: true
    add_column :sales, :multiplier, :integer
    add_column :sales, :multipliers, :text, array: true
  end
end
