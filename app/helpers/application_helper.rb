module ApplicationHelper
  def item_join(prod, item)
    Order.find_by(product_id: prod.id, inventory_item_id: item.id)
  end

  def link_to_add_row(name, f, association, **args)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.simple_fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize, identifier: id, f: builder)
    end
    link_to(name, '#', class: "add_fields " + args[:class], data: {id: id, fields: fields.gsub("\n", "")})
  end

  def user_is_admin?
    user_signed_in? &&
    current_user.username == 'paulcastro' ||
    current_user.username == 'onyoy2011' ||
    current_user.username == 'admin'
  end
end
