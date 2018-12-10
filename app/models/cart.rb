class Cart < ApplicationRecord

  has_many :line_items
  belongs_to :user
  # Ensures users only have one cart
  validates :user, uniqueness: true

  # Gets the total price of all items in the cart
  def get_total_price
    self.line_items.sum { |item| item.get_subtotal }
  end

  # Checks whether the cart is empty or not
  def is_cart_empty?
    total_price = self.get_total_price

    if total_price > 0
      return false
    else
      return true
    end
  end
end
