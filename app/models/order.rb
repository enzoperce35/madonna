class Order < ApplicationRecord
  belongs_to :product, optional: true
  belongs_to :inventory_item, optional: true
end
