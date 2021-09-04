class EditColumnsInProducts < ActiveRecord::Migration[6.1]
  def up
    change_column_default :products, :multiplier, 0
    change_column_default :products, :sales, 0
  end
  
  def down
    change_column_default :products, :multiplier, nil
    change_column_default :products, :sales, nil
  end
end
