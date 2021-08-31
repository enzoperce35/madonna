
module SalesHelper
  def collect_ids(product)
    sub = Subtractor.first

    sub.update(subtractives: sub.subtractives << product.id)
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
      IngredientsProduct.all.each do |join|
        product = Product.find_by(id: join.product_id)
        ingredient = Ingredient.find_by(id: join.ingredient_id)
        perform_subtraction_1(id, join, product, ingredient) if join.product_id == id
      end
    end
  end
  
  def deduct_packagings
    Subtractor.last.subtractives.each do |prod_id|
      id = prod_id.to_i
      PackagingsProduct.all.each do |join|
        product = Product.find_by(id: join.product_id)
        packaging = Packaging.find_by(id: join.packaging_id)
        perform_subtraction_2(id, join, product, packaging) if join.product_id == id
      end
    end
  end

  def def_subtractor
    sub = Subtractor.last

    sub.update(subtractives: [])
  end

  def def_multiplier
    product = Product.all
    
    product.each do |p|
      p.update(multiplier: 0)
    end
  end

  def return_default
    def_multiplier
    def_subtractor
  end

  def new_day?
    Time.current.beginning_of_day > Sale.last.created_at
  end

  def increment_sale
    if Sale.last.nil? || new_day? 
      1
    else
      Sale.last.sale_number + 1
    end
  end

  def product_total(total = 0)
    Product.all.each do |p|
      if p.multiplier > 0
        total += (p.price * p.multiplier)
      end
    end
    total
  end

end