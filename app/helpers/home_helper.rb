module HomeHelper
  def false_category(product)
    product.category == "Warehouse" ||
    product.category == "Packaging" ||
    product.category == "Special"
  end

  def get_day(expectation)
    today = Date.today.strftime("%A")
    
    days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday']
    
    index = today == 'Sunday' ? days.index('Monday') : days.index(today)
    
    days = days.rotate(index)

    expectation <= 0 ? 'exhausted' : days[expectation-1]
  end

  def expected_exhaustion(item)
    return 10 if (item.current_stock <= item.remaining_stock)
    
    legit_records = Record.where("sales > ?", 0)
    store_days = legit_records.where(created_at: item.last_restock.beginning_of_day..DateTime.current).count
    consume_days = item.current_stock - item.remaining_stock
    rate_per_unit = store_days / consume_days
    
    rate_per_unit * item.remaining_stock
  end
end
