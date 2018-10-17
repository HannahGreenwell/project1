class Cart < ApplicationRecord

  has_many :line_items
  belongs_to :user
  validates :user, uniqueness: true # only one cart per user!

  def get_total_price
    self.line_items.sum { |item| item.get_subtotal }
  end

  def is_cart_empty?
    total_price = self.get_total_price

    if total_price > 0
      return false
    else
      return true
    end
  end
end
