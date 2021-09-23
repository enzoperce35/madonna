class InventoriesController < ApplicationController
  def index
    #@ingredients = Ingredient.all.order(:name)
    #@packagings = Packaging.all.order(:name)
    @items = InventoryItem.all.order(:name)
  end

  def new
    @products = Product.all
  end

  def create
    @item= InventoryItem.new(item_params)

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

    unless params[:additional].nil? || params[:additional].nil?
      helpers.update_stock(@item, :inventory_items)
    end
    
    if @item.update(item_params)
      
      redirect_to inventories_path
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
    # have to put a white space on :current_stock, dkw?
    params.require(:inventory_items).permit(:name, :unit, :current_stock, product_ids: [])
  end
end
