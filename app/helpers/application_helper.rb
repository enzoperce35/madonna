module ApplicationHelper
  def add(inventory)
    inventory.remaining_stock += inventory.additional
    inventory.additional = nil
  end
  
  def minus(inventory)
    inventory.remaining_stock -= inventory.subtractive
    inventory.subtractive = nil
  end

  def apply_update(inventory)
    if !inventory.additional.nil?
      add(inventory)
    elsif !inventory.subtractive.nil?
      minus(inventory)
    end
  end

  def update_stock(inventory, data)
    inventory.update(add_params(data))
    inventory.update(sub_params(data))

    apply_update(inventory)
  end

  def add_params(data)
    params.require(data).permit(:additional)
  end
  
  def sub_params(data)
    params.require(data).permit(:subtractive)
  end

  def add_full_stock_of(inventory_item)
    inventory_item.remaining_stock = inventory_item.current_stock
    inventory_item
  end

  def prod_ingr(prod, ingr)
    Order.find_by(product_id: prod.id, ingredient_id: ingr.id)
  end
end
