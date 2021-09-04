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

    unless params[:additional].nil? || params[:additional].nil?
      helpers.update_stock(@packaging, :packagings)
    end
    
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

  def edit
    @packaging = Packaging.find(params[:id])
  end

  private

  def packaging_params
    # have to put a white space on :current_stock, dkw?
    params.require(:packagings).permit(:name, :unit, :current_stock, product_ids: [])
  end
end
