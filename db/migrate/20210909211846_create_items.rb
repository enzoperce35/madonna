class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :product
      t.integer :multiplier
      t.string :total
      t.belongs_to :sale, null: false, foreign_key: true, index: true

      t.timestamps
    end
  end
end
