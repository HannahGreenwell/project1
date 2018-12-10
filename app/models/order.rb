class Order < ApplicationRecord
  has_many :line_items, dependent: :destroy
  belongs_to :user

  # 'Moves' a customer's line items from their cart to their order following successful payment
  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      # Set the item's cart_id to nil so that line_items are no longer associated with the (so to be destroyed) cart
      item.cart_id = nil
      # Add the current line item to @order.line_items, so that the order_id
      # is automatically filled in by Rails
      self.line_items << item
    end
  end

  # Update stock levels aftet the completion of a successful order
  def update_inventory
    self.line_items.each do |item|
      update_qty = item.product_size.quantity - item.quantity
      item.product_size.update quantity: update_qty
    end
  end

  # Shortcut to the customer's details that are stored in the stripe_charge_repsonse column of the orders table
  def customer_details
    self.stripe_charge_response["source"]
  end
end
