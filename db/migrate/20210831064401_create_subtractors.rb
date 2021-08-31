class CreateSubtractors < ActiveRecord::Migration[6.1]
  def change
    create_table :subtractors do |t|
      t.text :subtractives

      t.timestamps
    end
  end
end
