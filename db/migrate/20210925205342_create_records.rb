class CreateRecords < ActiveRecord::Migration[6.1]
  def change
    create_table :records do |t|
      t.integer :day
      t.float :sales
      t.text :items, array: true

      t.timestamps
    end
  end
end
