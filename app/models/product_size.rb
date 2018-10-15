class ProductSize < ApplicationRecord
  belongs_to :product, optional: true
  has_many :line_items

  enum size: ['os', 'xsmall', 'small', 'medium', 'large', '39', '40', '41', '42']
end
