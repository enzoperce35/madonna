module InventoriesHelper

  def update_stock_of(inventory_item)
    inventory_item.update(remaining_stock: inventory_item.current_stock)
    inventory_item
  end
  
  def add_full_stock_of(inventory_item)
    inventory_item.remaining_stock = inventory_item.current_stock
    inventory_item
  end
end
