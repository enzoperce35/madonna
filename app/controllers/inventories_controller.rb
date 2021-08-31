class InventoriesController < ApplicationController
  def index
    @ingredients = Ingredient.all.order(:name)
    @packagings = Packaging.all.order(:name)
  end
end
