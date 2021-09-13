class Item < ApplicationRecord
  belongs_to :sale, optional: true
end
