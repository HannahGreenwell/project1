class ApplicationController < ActionController::Base

  before_action :fetch_user

  private

  # Check if user is logged in and redirect users not logged in to login page
  def check_if_logged_in
    unless @current_user.present?
      flash[:login_error] = "Please login to view that page."
      redirect_to login_path
    end
  end

  # Get current user from sessions and set the @current_user variable
  def fetch_user
      if session[:user_id].present?
        @current_user = User.find_by id: session[:user_id]
      end

      # Handle cases where user deleted their account but still have an active session
      session[:user_id] = nil unless @current_user.present?
  end

  # Get current user's cart or create a new cart if they do not have one
  def fetch_cart_and_check_inventory
    @cart = Cart.find_or_create_by user_id: @current_user.id

    # Check user's line items against current inventory levels
    updated_line_items = []

    @cart.line_items.each do |item|
      if item.quantity > item.product_size.quantity
        update_qty = item.get_update_qty item.quantity
        item.update quantity: update_qty
        updated_line_items << item
      end
    end

    # If items in the user's cart had to be adjusted,
    # redirect to carts#user_cart and set flash error
    if updated_line_items.length > 0
      flash[:item_error] = "Sorry, stock is running low. Your shopping basket has been adjusted accordingly."
      redirect_to cart_path
      return
    end
  end
end
