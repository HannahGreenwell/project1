class Cart < ApplicationRecord

  belongs_to :user
  validates :user, uniqueness: true # only one cart per user!

  has_many :line_items

  def total_price
  end

  # Method that finds and returns a user's cart.
  # If no cart is found a new cart is created and returned.
  def self.fetch_or_create_for_user(user)
    puts "FETCH OR CREATE"
    Cart.find_or_create_by(user_id: user.id)
  end
end
