class LineItem < ApplicationRecord
  belongs_to :cart, optional: true
  belongs_to :product_size, optional: true
  belongs_to :order, optional: true

  # Gets the subtotal of the line_item 
  def get_subtotal
    self.product_size.product.price * self.quantity
  end

  # Checks the requested qty against current stock levels
  # If requested qty can't be fulfilled, adjust the update qty
  def get_update_qty(requested_qty)
    update_qty = requested_qty

    if self.product_size.quantity < requested_qty
      update_qty = self.product_size.quantity
    end

    update_qty
  end

  # Shortcut to a product through product_size
  def product
    self.product_size.product
  end
end
