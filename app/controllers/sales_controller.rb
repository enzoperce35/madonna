class SalesController < ApplicationController
  before_action :force_json, only: :search
  
  # 'Subtractor': a helper model, must not be deleted, if so: dev must create one
  #  and set 'subtractives' column to an empty array
  # 'subtractives' is where product ids were collected during user picking of orders
  
  # passes the sale values to the official receipt page
  def show
    @sale = Sale.find(params[:id])
  end

  # passes the sale total to the sale total editor page
  def alter_total
    @total = helpers.product_total
  end

  def deduct_used_iventory_items
    helpers.deduct_ingredients
    
    #helpers.deduct_packagings
  end

  def user_edited_the_sale
    params[:sales].present?
  end

  # bring product values to their default if the user discarded the order
  def discard
    helpers.restore_default

    redirect_back(fallback_location: 'new')
  end

  def update
    @sale = Sale.find(params[:id])

    if @sale.update(sale_params)
      redirect_to root_path
    else
      redirect_to inventories_path
    end
  end

  def destroy
    @sale = Sale.find(params[:id])

    # this method is soon to be used as soon as inventory subtractiona amount feature is enabled!
    # helpers.reinburse_inventory(@sale.sale_phrase)

    if @sale.destroy
      redirect_to root_path
    end
  end

  # create a new sale if orders were confirmed by the user
  def create
    @sale = Sale.new(sale_params)
    #@sale = Sale.new(params.require(:sales).permit(:product_ids, :multipliers))
    
    if @sale.save
      redirect_back(fallback_location: 'new')
    end

    # set the sale's values
    #if user_edited_the_sale
      #@new_sale = Sale.new(sale_params)
      
      #@new_sale.sale_number = helpers.incr_sale_number
      
      #@new_sale.total = helpers.product_total
    #else
      #@new_sale = Sale.create(total: helpers.product_total, sale_number: helpers.incr_sale_number)
    #end
    # save the sale and it's values
    #if @new_sale.save
      # set the sale phrases for the official receipt
      #@new_sale.update(sale_phrase: helpers.log_products)
      # deduct tagged inventory items to each product sold
      #deduct_used_iventory_items
      # remove each product ids from subtractor
      # bring product multipliers to zero again
      #helpers.restore_default

      #redirect_to new_sale_path
    #else
      #redirect_to new_sale_path
    #end
  end
  
  # when the product name is clicked:
  def orders
    # find the product the user clicked
    @product = Product.find(params[:id])
    # increment the product's multiplier
    @product.update(multiplier: @product.multiplier + 1)
    # collect the product id
    helpers.collect_ids(@product)
    # get back to sales page to make the user choose again
    redirect_back(fallback_location: 'new')
  end
  
  # these will render the sales page multiple times
  # and pass these values each time
  def new
    @products = Product.all.pluck(:name).sort
    # an incremented sale number
    #@sale_number = helpers.incr_sale_number
    # list of all products
    #@products = Product.where(:multiplier => 0).order(:name)
    #@order_items = Product.where.not(:multiplier => 0).order(updated_at: :desc)
    # total price of chosen products
    #@total = helpers.product_total
  end

  def show_total
    sale_today = Sale.where("created_at >= ?", Time.zone.now.beginning_of_day)
    @total_sales = 0
    sale_today.each do |sale|
      if sale.edited_total.nil?
        @total_sales += sale.total
      else
        @total_sales += sale.edited_total.to_i
      end
      @total_sales
    end
    
  end

  def search
    q = params[:q].downcase
    @products = Product.where("name ILIKE ?", "%#{q}%").limit(5)
  end

  private

  def sale_params
    params.require(:sales).permit(:sale_number, :edited_total, :note, :total, :admin_notice, :product_id, :multiplier )
  end

  def force_json
    request.format = :json
  end
end