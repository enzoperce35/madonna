class OrdersController < ApplicationController
  def update
    join = Order.find(params[:id])
    
    if join.update(join_params)
      updated_item = InventoryItem.find_by(id: join.inventory_item_id)
      
      redirect_to inventory_path(updated_item)
    else
      redirect_to inventories_path
    end
  end

  def edit
    @join = Order.find(params[:id])
  end
  
  private
  
  def join_params 
    params.require(:orders).permit(:subtractive)
  end
end
