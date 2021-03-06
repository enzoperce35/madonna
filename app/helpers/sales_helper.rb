module SalesHelper
  def group_categories(arr = [])
    categories = Product.pluck(:category)

    categories.uniq.each do |category|
      group = Product.where(category: category).order(:name)

      arr << [category, group]
    end
    arr
  end
  
  def create_record(sale, reverse = false, item_ids = [])
    daily_record = Record.last
    deducted_items = daily_record.items
    
    sale.items.each do |item|
      if reverse
        item.multiplier.times do |i|
          index = daily_record.items.index(item.product)
          
          deducted_items.delete_at(index)
        end
      else
        item.multiplier.times { item_ids << item.product }
      end
    end

    added_items = daily_record.items + item_ids
    
    daily_record.update(sales: accumulate_sales, items: reverse ? deducted_items : added_items)
  end

  def accumulate_sales
    sale_today = Sale.where("created_at >= ?", Time.zone.now.beginning_of_day)
    total_sales = 0
    sale_today.each do |sale|
      if sale.edited_total.nil?
        total_sales += sale.total
      else
        total_sales += sale.edited_total.to_i
      end
    end
    total_sales
  end
  
  def deduct_inventory_items(id, count, reverse)
    product = Product.find_by(id: id)

    product.inventory_items.each do |item|
      join = Order.find_by(product_id: id, inventory_item_id: item.id)

      if reverse
        item_stock = item.remaining_stock + (join.subtractive * count)
      else
        item_stock = item.remaining_stock - (join.subtractive * count)
      end

      item.update(remaining_stock: item_stock)
    end
  end
  
  def update_inventory(sale, reverse = false)
    sale.items.each do |item|
      product_id = item.product
      product_count = item.multiplier

      deduct_inventory_items(product_id, product_count, reverse)
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
  
  def incr_day_number
    if Record.last.nil?
      1
    else
      Record.last.day + 1
    end
  end

  def no_record_for_today?
    Record.where(created_at: Date.today.all_day).blank?
  end
end
