class IngredientsController < ApplicationController
  def new
    @products = Product.all
  end

  def create
    @ingredient = Ingredient.new(ingredient_params)

    helpers.add_full_stock_of(@ingredient)
    
    if @ingredient.save
      redirect_to inventories_path
    else
      redirect_back(fallback_location: 'new')
    end
  end

  def show
    @ingredient = Ingredient.find(params[:id])
  end

  def update
    @ingredient = Ingredient.find(params[:id])

    helpers.update_stock(@ingredient, :ingredients)
    
    if @ingredient.update(ingredient_params)
      
      redirect_to inventories_path
    end
  end

  def destroy
    @ingredient = Ingredient.find(params[:id])
  
    if @ingredient.destroy
      redirect_to inventories_path
    end
  end

  private

  def ingredient_params
    # have to put a white space on :current_stock, dkw?
    params.require(:ingredients).permit(:name, :unit, :current_stock, product_ids: [])
  end
end
