class InventoriesController < ApplicationController
  def index
    @ingredients = InventoryItem.where(item_type: 'ingredient').order(:name)
    @packagings = InventoryItem.where(item_type: 'packaging').order(:name)
  end

  def new
    @item_type = params[:item_type]
    @products = Product.all
  end

  def create
    @item = InventoryItem.new(item_params)

    helpers.add_full_stock_of(@item)
    
    if @item.save
      redirect_to inventories_path
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
      
      helpers.update_stock_of(@item)
      
      redirect_to inventory_path(@item)
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
    params.require(:inventory_items).permit(:name, :unit, :current_stock, :additional, :subtractive, :item_type, product_ids: [])
  end
end
