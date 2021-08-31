class PackagingsController < ApplicationController
  def new
    @products = Product.all
  end

  def create
    @packaging = Packaging.new(packaging_params)

    helpers.add_full_stock_of(@packaging)
    
    if @packaging.save
      
      redirect_to inventories_path
    else
      redirect_back(fallback_location: 'new')
    end
  end

  def show
    @packaging = Packaging.find(params[:id])
  end

  def update
    @packaging = Packaging.find(params[:id])

    helpers.update_stock(@packaging, :packagings)
    
    if @packaging.update(packaging_params)
      
      redirect_to inventories_path
    end
  end

  def destroy
    @packaging = Packaging.find(params[:id])
  
    if @packaging.destroy
      redirect_to inventories_path
    end
  end

  private

  def packaging_params
    # have to put a white space on :current_stock, dkw?
    params.require(:packagings).permit(:name, :current_stock , :unit, product_ids: [])
  end
end
