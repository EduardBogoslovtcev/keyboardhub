class Product < ApplicationRecord
  belongs_to :brand
  belongs_to :layout
  belongs_to :switch_type
end
