class Product < ApplicationRecord
  validates_presence_of :name, :price, on: :create
  validates_uniqueness_of :name, on: :create
  has_many :orders
  has_many :ingredients, through: :orders
  has_many :packagings, through: :orders
end