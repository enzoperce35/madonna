class OrdersController < ApplicationController
  def update
    join = Order.find(params[:id])
    
    if join.update(join_params) 
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
