class ProductsController < ApplicationController
   before_action :force_json, only: :search
  def new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to products_path, method: 'get'
    else
      redirect_back(fallback_location: 'new')
    end
  end

  def index
    @products = Product.all
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

  def search
    q = params[:q].downcase
    @products = Product.where("name ILIKE ?", "%#{q}%").limit(5)
  end

  private

  def product_params
    params.require(:products).permit(:name, :price)
  end

  def force_json
    request.format = :json
  end
end