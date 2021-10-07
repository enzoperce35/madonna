class Product < ApplicationRecord
  validates_presence_of :name, :price, :category, on: [:create, :edit]
  validates_uniqueness_of :name, on: [:create, :edit]
  has_many :orders, dependent: :destroy
  has_many :inventory_items, through: :orders
end