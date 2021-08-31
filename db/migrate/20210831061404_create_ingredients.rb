class CreateIngredients < ActiveRecord::Migration[6.1]
  def change
    create_table :ingredients do |t|
      t.string :name
      t.string :unit
      t.float :current_stock
      t.float :subtractive
      t.float :additional
      t.float :remaining_stock

      t.timestamps
    end
  end
end
