class Cart < ApplicationRecord

  belongs_to :user
  validates :user, uniqueness: true # only one cart per user!

  has_many :line_items, dependent: :destroy

  def total_price
  end
end
