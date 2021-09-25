module SalesHelper
  
  def deduct_inventory_items(id, count)
    product = Product.find_by(id: id)

    product.inventory_items.each do |item|
      join = Order.find_by(product_id: id, inventory_item_id: item.id)

      item_stock = item.remaining_stock - (join.subtractive * count)

      item.update(remaining_stock: item_stock)
    end
  end
  
  def update_inventory(sale)
    sale.items.each do |item|
      product_id = item.product
      product_count = item.multiplier

      deduct_inventory_items(product_id, product_count)
    end
  end
  
  def create_sale_phrase(sale, arr = [])
    sale.items.each do |item|
      product = Product.find_by(id: (item.product).to_i)
      price = product.price * item.multiplier
      phrase = "#{product.name}$#{product.price}$#{item.multiplier}$#{price}"
      arr << phrase
    end
    arr
  end
  
  def create_total(sale, total = 0)
    sale.items.each do |item|
      product = Product.find_by(id: (item.product).to_i)
      price = product.price * item.multiplier
      total += price
    end
    total
  end

  def new_day?
    Time.current.beginning_of_day > Sale.last.created_at
  end
  
  def incr_sale_number
    if Sale.last.nil? || new_day? 
      1
    else
      Sale.last.sale_number + 1
    end
  end
end