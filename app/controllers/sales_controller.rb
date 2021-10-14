class SalesController < ApplicationController
  before_action :initialize_record, only: [:create]
  
  def show
    @sale = Sale.find(params[:id])
  end

  def show_total
    @total_sales = helpers.accumulate_sales
  end

  def update
   @sale = Sale.find(params[:id])
   
   if @sale.update(sale_params)
     redirect_to root_path
   else
     redirect_back
   end
  end

  def destroy
    @sale = Sale.find(params[:id])

    helpers.update_inventory(@sale, true)
    helpers.create_record(@sale, true)
    
    @sale.destroy
    
    Record.last.update(sales: helpers.accumulate_sales)
    
    redirect_to root_path
  end

  def edit
    @sale.items.build
  end

  def create
    @sale = Sale.new(sale_params)
    @sale.sale_number = helpers.incr_sale_number
    @sale.total = helpers.create_total(@sale)
    @sale.sale_phrase = helpers.create_sale_phrase(@sale)
    @sale.editor = current_user.username
    
    if @sale.save
      helpers.update_inventory(@sale)
      helpers.create_record(@sale)
      
      redirect_back(fallback_location: 'new')
    end
  end

  def new
    @categories = helpers.group_categories
    @product_ids = Product.pluck(:id)
    @products = Product.pluck(:price)
    @sale = Sale.new
    @sale.items.build
    @blocks = Array.new
  end

  def delete_request
    @sale = Sale.find(params[:id])
  end

  private

  def initialize_record
    if helpers.no_record_for_today?
      Record.create(day: helpers.incr_day_number, items: [])

      Sale.destroy_all
    end
  end

  def set_sale_items
    @sale_items = Sale.find(params[:id])
  end

  def sale_params
    params.require(:sale).permit(:sale_number, :edited_total, :note, :total, :admin_note, :product_id, :multiplier, items_attributes: Item.attribute_names.map(&:to_sym).push(:_destroy))
  end
end
