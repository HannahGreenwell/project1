class LineItem < ApplicationRecord
  belongs_to :cart, optional: true
  belongs_to :product_size, optional: true

  def total_price
    self.product_size.product.price * self.quantity
  end

  # Checks the requested stock quantity against the actual stock on hand
  # and returns the lesser of the two
  def get_update_qty(requested_qty)
    update_qty = requested_qty

    if self.product_size.quantity < requested_qty
      update_qty = self.product_size.quantity
    end

    update_qty
  end

  # Gets a product from a line_item through product_size
  def product
    self.product_size.product
  end
end
