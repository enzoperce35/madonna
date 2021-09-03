class SalesController < ApplicationController
  
  def new
    @sale_number = helpers.increment_sale
    
    @product = Product.all.order(:name)
    
    @total = helpers.product_total
  end
  
  # when the product name is clicked:
  def orders
    # find the product the user clicked
    @product = Product.find(params[:id])
    # increment the product's multiplier
    @product.update(multiplier: @product.multiplier + 1)
    # collect the product id
    helpers.collect_ids(@product)
    # get back to the page to make the user choose again
    redirect_back(fallback_location: 'new')
  end

  # create a new sale if orders were confirmed by the user
  def create
    if params[:sales].present?
      @new_sale = Sale.new(sale_params)
      
      @new_sale.sale_number = helpers.increment_sale
      
      @new_sale.total = helpers.product_total
    else
      @new_sale = Sale.create(total: helpers.product_total, sale_number: helpers.increment_sale)
    end
    
    if @new_sale.save
      
      @new_sale.update(sale_phrase: helpers.log_products)
      
      helpers.deduct_ingredients
    
      helpers.deduct_packagings

      helpers.return_default

      redirect_to new_sale_path
    else
      redirect_to new_sale_path
    end
  end

  def alter_total
    @total = helpers.product_total
  end

  def discard
    helpers.return_default

    redirect_back(fallback_location: 'new')
  end

  def show
    @sale = Sale.find(params[:id])
  end

  private

  def sale_params
    params.require(:sales).permit(:sale_number, :edited_total, :note)
  end
end
