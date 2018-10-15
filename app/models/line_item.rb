class LineItem < ApplicationRecord
  belongs_to :cart, optional: true
  belongs_to :product_size, optional: true

  def total_price
    self.product_size.product.price * self.quantity
  end

  # Gets a product from a line_item through product_size
  def product
    self.product_size.product
  end
end
