class Product < ApplicationRecord
  has_many :images
  has_many :line_items
end
