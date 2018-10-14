class Cart < ApplicationRecord
  belongs_to :user
  has_many :line_items, dependent: :destroy

  def total_price
    
  end
end
