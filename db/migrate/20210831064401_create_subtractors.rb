class CreateSubtractors < ActiveRecord::Migration[6.1]
  def change
    create_table :subtractors do |t|
      t.text :subtractives, array: true

      t.timestamps
    end
  end
end
