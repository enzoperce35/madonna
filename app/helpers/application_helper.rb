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




  def link_to_add_row(name, f, association, **args)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.simple_fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize, f: builder)
    end
    link_to(name, '#', class: "add_fields " + args[:class], data: {id: id, fields: fields.gsub("\n", "")})
  end
end
