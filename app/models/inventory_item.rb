class InventoryItem < ApplicationRecord
  validates_uniqueness_of :name, on: :create
  validates_presence_of :name, :unit, :maximum_stock, :remaining_stock, :margin, on: :create
  validates_presence_of :name, :unit, :maximum_stock, :margin, on: :update
  has_many :orders, dependent: :destroy
  has_many :products, through: :orders
end
