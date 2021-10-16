module InventoriesHelper

  def update_stock_of(inventory_item)
    inventory_item.update(remaining_stock: inventory_item.current_stock)
    
    inventory_item.update(last_restock: inventory_item.updated_at)
    
    inventory_item
  end
  
  def add_last_restock_of(inventory_item)
    inventory_item.update(last_restock: inventory_item.created_at)
  end
  
  def add_full_stock_of(inventory_item)
    inventory_item.remaining_stock = inventory_item.current_stock
    inventory_item
  end
end
