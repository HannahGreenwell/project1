class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  has_one :cart, dependent: :destroy
  has_many :orders
end
