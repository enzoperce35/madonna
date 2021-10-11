class Sale < ApplicationRecord
  has_many :items, dependent: :delete_all
  accepts_nested_attributes_for :items, allow_destroy: true, reject_if: proc { |att| att['product'].blank? || att['multiplier'].blank? }
  #accepts_nested_attributes_for :items, allow_destroy: true, reject_if: :all_blank
end
