module HomeHelper
  def false_category(product)
    product.category == "Warehouse" ||
    product.category == "Packaging" ||
    product.category == "Special"
  end
end
