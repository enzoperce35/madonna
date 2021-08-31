class Order < ApplicationRecord
  belongs_to :product
  belongs_to :ingredient
  belongs_to :packaging
end
