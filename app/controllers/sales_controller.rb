class SalesController < ApplicationController
  
  def show
    @sale = Sale.find(params[:id])
  end

  def update
   if @sale.update(sale_params)
     redirect_to @sale, notice: 'Sale was successfully updated'
   else
    render 'edit'
   end
  end

  def destroy
    @sale.destroy
    redirect_to sales_url, notice: 'Sales was successfully destroyed'
  end

  def edit
    @sale.items.build
  end

  def create
    @sale = Sale.new(sale_params)
    @sale.sale_number = helpers.incr_sale_number
    @sale.total = helpers.create_total(@sale)
    @sale.sale_phrase = helpers.create_sale_phrase(@sale)
    if @sale.save
      helpers.update_inventory(@sale)
      
      redirect_back(fallback_location: 'new')
    end
  end

  def new
    @products = Product.pluck(:price)
    @sale = Sale.new
    @sale.items.build
    @blocks = Array.new
  end

  private

  def set_sale_items
    @sale_items = Sale.find(params[:id])
  end

  def sale_params
    params.require(:sale).permit(:sale_number, :edited_total, :note, :total, :admin_notice, :product_id, :multiplier, items_attributes: Item.attribute_names.map(&:to_sym).push(:_destroy))
  end
end