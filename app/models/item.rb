class Item < ApplicationRecord
  belongs_to :sales, optional: true
end
