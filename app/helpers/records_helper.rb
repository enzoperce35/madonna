module RecordsHelper
  def readable(date)
    date.to_date.strftime('%b %e')
  end

  def arrange(records, arr = [])
    items = records.pluck(:items).flatten
    
    items.each do |item|
      product = Product.find_by(id: item)
      
      next if product.nil?
      
      arr << product.name
    end
    arr.sort
  end
end
