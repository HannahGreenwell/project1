class CartsController < ApplicationController

  before_action :check_if_logged_in, :fetch_cart

  def destroy
    ### Destroy when order processed
  end

  def user_cart
    # Get the current user's cart. If the current user
    # doesn't have a cart, then create one
    render :show
  end
end
