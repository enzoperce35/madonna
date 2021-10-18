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
    
    if @item.save
      @item.update(last_restock: @item.created_at)
      
      redirect_to chart_path(item_type: @item.item_type.sub('parent_', ''))
    else
      redirect_back(fallback_location: 'new')
    end
  end

  def show
    @item = InventoryItem.find(params[:id])
  end

  def update
    @item = InventoryItem.find(params[:id])

    if @item.update(item_params)
      @item.update(last_restock: @item.updated_at) if params[:inventory_items][:remaining_stock].present?
      
      redirect_to chart_path(item_type: @item.item_type.sub('parent_', ''))
    else
      redirect_to root_path
    end
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
    params.require(:inventory_items).permit(:name, :unit, :maximum_stock, :remaining_stock, :margin, :item_type, product_ids: [])
  end
end
