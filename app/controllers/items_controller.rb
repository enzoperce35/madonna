class ItemsController < ApplicationController
  def new
    #@sale = Sale.new
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def create
    @item = Item.new(item_params)

    @sale = Sale.new(items: [@item])

    if @sale.save
      redirect_back(fallback_location: 'new')
    end
  end

  private

  def item_params
    params.require(:items).permit(:product, :multiplier, :sale_id)
  end
end
