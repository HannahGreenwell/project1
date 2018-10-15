class LineItemsController < ApplicationController

  before_action :check_if_logged_in, :fetch_cart

  def create
    # Check if the user already has the item in their cart
    current_item = LineItem.find_by product_id: params[:product_id], cart_id: @cart.id

    # If the item is already in the user's cart, increment the quantity
    # If the item is not in the user's cart create a new line_item record
    if current_item.present?
      current_item.quantity += 1
    else
      current_item = LineItem.new product_id: params[:product_id], cart_id: @cart.id
    end

    current_item.save
    redirect_to cart_path
  end

  def update
    ### TIER 2
  end

  def destroy
    line_item = LineItem.find params[:id]
    line_item.destroy

    redirect_to cart_path
  end
end
