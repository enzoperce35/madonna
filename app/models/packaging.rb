class Packaging < ApplicationRecord
  validates_uniqueness_of :name, on: :create
  validates_presence_of :name, :products, :unit, :current_stock, on: :create
  has_many :orders
  has_many :products, through: :orders
end
