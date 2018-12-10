class CartsController < ApplicationController

  before_action :check_if_logged_in, :fetch_cart_and_check_inventory

  # My Basket
  def user_cart
    render :show
  end
end
