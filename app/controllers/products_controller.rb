class ProductsController < ApplicationController
  def new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to root_path
    else
      redirect_back(fallback_location: 'new')
    end
  end

  private

  def product_params
    params.require(:products).permit(:name, :price)
  end
end