class LineItem < ApplicationRecord
  belongs_to :cart, optional: true
  belongs_to :product, optional: true

  def total_price
    self.product.price * self.quantity
  end
end
