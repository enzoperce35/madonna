module HomeHelper
  def false_category(product)
    product.category == "Warehouse" ||
    product.category == "Packaging" ||
    product.category == "Special"
  end

  def expected_exhaustion(item)
    return 10 if item.current_stock < item.remaining_stock
    
    if item.last_restock.nil?
      item.update(last_restock: item.created_at)
    end

    store_days = Record.where(created_at: item.last_restock..DateTime.current).count
    consume_days = item.current_stock - item.remaining_stock
    rate_per_unit = store_days / consume_days
    
    rate_per_unit * item.remaining_stock
  end
end
