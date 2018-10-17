class Order < ApplicationRecord
  has_many :line_items, dependent: :destroy
  belongs_to :user

  # serialize :stripe_charge_response, JSON

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil  # Set cart_id to nil so line_items are not lost when cart is destroyed
      # Add the current line item to @order.line_items, so that the foreign key field (order_id) # is automatically filled in by Rails
      self.line_items << item
    end
  end
end
