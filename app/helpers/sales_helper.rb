module SalesHelper
  def product_list
    Product.find_each do |p|
      p.multiplier > 0
    end
  end 
  def log_products(arr = [])
    Subtractor.last.subtractives.each do |prod_id|
      id = prod_id.to_i

      product = Product.find_by(id: id)

      total = product.price * product.multiplier

      phrase = "#{product.name},#{product.price},#{product.multiplier},#{total}"

      arr << phrase

    end
    arr.uniq
  end

  def perform_subtraction_1(id, join, product, ingredient)
    
    ingredient.update(remaining_stock: ingredient.remaining_stock - join.subtractive)
  end
  
  def perform_subtraction_2(id, join, product, packaging)
    
    packaging.update(remaining_stock: packaging.remaining_stock - join.subtractive)
  end

  def deduct_ingredients
    Subtractor.last.subtractives.each do |prod_id|
      id = prod_id.to_i
      Order.all.each do |join|
        product = Product.find_by(id: join.product_id)
        ingredient = Ingredient.find_by(id: join.ingredient_id)
        perform_subtraction_1(id, join, product, ingredient) if join.product_id == id
      end
    end
  end
  
  def deduct_packagings
    Subtractor.last.subtractives.each do |prod_id|
      id = prod_id.to_i
      Order.all.each do |join|
        product = Product.find_by(id: join.product_id)
        packaging = Packaging.find_by(id: join.packaging_id)
        perform_subtraction_2(id, join, product, packaging) if join.product_id == id
      end
    end
  end

  def restore_subtractor
    sub = Subtractor.last

    sub.update(subtractives: [])
  end

  def restore_multiplier
    product = Product.all
    
    product.each do |p|
      p.update(multiplier: 0)
    end
  end

  def restore_default
    restore_multiplier
    restore_subtractor
  end

  def new_day?
    Time.current.beginning_of_day > Sale.last.created_at
  end

  def collect_ids(product)
    sub = Subtractor.first
    
    sub.update(subtractives: sub.subtractives << product.id)
  end

  
  def product_total(total = 0)
    Product.all.each do |p|
      if p.multiplier > 0
        total += (p.price * p.multiplier)
      end
    end
    total
  end

  def reinburse_inventory(sale_phrase)
    sale_phrase.each do |phrase|
      name,multiplier = phrase[0],phrase[2].to_i

      product = Product.find_by(name: name)
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
  
  def incr_sale_number
    if Sale.last.nil? || new_day? 
      1
    else
      Sale.last.sale_number + 1
    end
  end

end