class Product < ApplicationRecord
  belongs_to :brand
  belongs_to :layout
  belongs_to :switch_type
  has_many :order_items
end
