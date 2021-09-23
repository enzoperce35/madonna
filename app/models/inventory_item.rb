class InventoryItem < ApplicationRecord
  validates_uniqueness_of :name, on: :create
  validates_presence_of :name, :unit, :current_stock, on: :create
  has_many :orders, dependent: :destroy
  has_many :products, through: :orders
end
