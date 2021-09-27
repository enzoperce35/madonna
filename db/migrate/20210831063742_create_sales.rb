class CreateSales < ActiveRecord::Migration[6.1]
  def change
    create_table :sales do |t|
      t.integer :sale_number, default: 1
      t.float :total
      t.float :edited_total
      t.text :note
      t.text :sale_phrase, array: true
      t.text :admin_note
      t.string :editor

      t.timestamps
    end
  end
end
