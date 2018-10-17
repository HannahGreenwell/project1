class CartsController < ApplicationController

  before_action :check_if_logged_in, :fetch_cart

  def user_cart
    render :show
  end
end
