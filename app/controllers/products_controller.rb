class ProductsController < ApplicationController
  
  def new
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])

    if @product.update(product_params)
      redirect_to products_path
    else
      redirect_back(fallback_location: 'new')
    end
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to products_path, method: 'get', notice: 'Product has been added' 
    else
      redirect_back(fallback_location: 'new')
    end
  end

  def index
    @products = Product.all.order(:name)
  end

  def show
    @product = Product.find(params[:id])
  end

  def destroy
    @product = Product.find(params[:id])

    if @product.destroy
      redirect_to products_path, method: 'get'
    else
      redirect_back(fallback_location: 'index')
    end
  end

  private

  def product_params
    params.require(:products).permit(:name, :price, :category)
  end
end