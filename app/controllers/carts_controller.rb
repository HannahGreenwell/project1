class CartsController < ApplicationController

  before_action :check_if_logged_in, :fetch_cart

  def user_cart
    # @cart = Cart.fetch_or_create_for_user @current_user
    render :show
  end
end
