class Sale < ApplicationRecord
  has_many :items, dependent: :destroy
  #accepts_nested_attributes_for :items, allow_destroy: true, reject_if: proc { |att| att['sale_number'].blank? }
  accepts_nested_attributes_for :items, allow_destroy: true, reject_if: :all_blank
end
