class ApplicationController < ActionController::Base

  before_action :fetch_user

  private

  def check_if_logged_in
    unless @current_user.present?
      flash[:login_error] = "You must be logged in to view that page."
      redirect_to login_path
    end
  end

  def fetch_user
      if session[:user_id].present?
        @current_user = User.find_by id: session[:user_id]
      end

      session[:user_id] = nil unless @current_user.present?
  end

  def fetch_cart_and_check_inventory
    @cart = Cart.find_or_create_by user_id: @current_user.id

    updated_line_items = []

    @cart.line_items.each do |item|
      if item.quantity > item.product_size.quantity
        update_qty = item.get_update_qty item.quantity
        item.update quantity: update_qty
        updated_line_items << item
      end
    end

    if updated_line_items.length > 0
      flash[:item_error] = "Sorry, stock is running low. Your shopping basket has been adjusted accordingly."
      redirect_to cart_path
      return updated_line_items ### TEST?
    end
  end
end
