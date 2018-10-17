class Cart < ApplicationRecord

  has_many :line_items
  belongs_to :user
  validates :user, uniqueness: true # only one cart per user!

  def get_total_price
    self.line_items.sum { |item| item.get_subtotal }
  end
end
