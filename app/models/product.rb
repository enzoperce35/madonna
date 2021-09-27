class Product < ApplicationRecord
  validates_presence_of :name, :price, :category, on: :create
  validates_uniqueness_of :name, on: :create
  has_many :orders, dependent: :destroy
  has_many :inventory_items, through: :orders
end