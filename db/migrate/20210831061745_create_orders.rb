class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.belongs_to :product, null: false, foreign_key: true, index: true
      t.belongs_to :ingredient, null: false, foreign_key: true, index: true
      t.belongs_to :packaging, null: false, foreign_key: true, index: true
      t.float :subtractive, default: 1

      t.timestamps
    end
  end
end
