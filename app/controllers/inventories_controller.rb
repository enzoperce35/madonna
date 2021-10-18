class InventoriesController < ApplicationController
  def index
  end

  def show_chart
    @item_type = params[:item_type]
   
    child = @item_type
    parent = 'parent_' + @item_type
     
    @child = InventoryItem.where(item_type: child).order(:name)
    @parent = InventoryItem.where(item_type: parent).order(:name)
  end

  def new
    @item_type = params[:item_type]
    @products = Product.all
  end

  def create
    @item = InventoryItem.new(item_params)

    helpers.add_full_stock_of(@item)
    
    if @item.save
      helpers.add_last_restock_of(@item)
      
      redirect_back(fallback_location: 'new')
    else
      redirect_to inventories_path
    end
  end

  def show
    @item = InventoryItem.find(params[:id])
  end

  def update
    @item = InventoryItem.find(params[:id])

    if @item.update(item_params)
      redirect_to inventory_path(@item)
    else
      redirect_to root_path
    end
  end

  def update_stock
    @item = InventoryItem.find(params[:id])
    
    #@item.update(params.require(:inventory_items).permit(:deductor))

    @item.update(params.require(:inventory_items).permit(:current_stock))
    
    helpers.update_stock_of(@item)

    redirect_to inventory_path(@item)
  end
  
  def destroy
    @item = InventoryItem.find(params[:id])
  
    if @item.destroy
      redirect_to inventories_path
    end
  end

  def edit
    @item = InventoryItem.find(params[:id])
  end

  private

  def item_params
    params.require(:inventory_items).permit(:name, :unit, :current_stock, :item_type, product_ids: [])
  end
end
