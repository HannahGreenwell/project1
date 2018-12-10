class LineItemsController < ApplicationController

  before_action :check_if_logged_in
  before_action :fetch_cart_and_check_inventory, except: [:destroy]

  # Add item to cart from product show page
  def create
    # Find the item in the user's cart, if the user does not already
    # have the item in their cart, create a new line_item
    current_item = LineItem.find_or_create_by product_size_id: params[:product_size_id], cart_id: @cart.id

    # Increment the item's quantity by one
    requested_qty = current_item.quantity + 1

    # Invoke method in line_item.rb that checks the
    # requested qty against current stock levels
    update_qty = current_item.get_update_qty requested_qty

    # If the user's requested quantity can not be fulfilled, set a flash error
    unless update_qty == requested_qty
      flash[:item_error] = "Sorry, not enough stock. Your shopping basket has been adjusted accordingly."
    end

    # Save the line_item update
    current_item.update quantity: update_qty

    # Redirect to My Basket page
    redirect_to cart_path
  end

  # Edit item qty from My Basket page
  def update
    requested_qty = params[:quantity].to_i

    # Check that user hasn't entered invalid qty
    unless requested_qty > 0
      flash[:item_error] = 'Please enter a valid quantity.'
      redirect_to cart_path
      return
    end

    # Get the line_item to update
    current_item = LineItem.find params[:id]

    # Ensure users don't update line items that don't belong to their cart
    unless @cart.line_items.include?(current_item)
      redirect_to cart_path
      return
    end

    # Invoke method in line_item.rb that checks the
    # requested qty against current stock levels
    update_qty = current_item.get_update_qty requested_qty

    # If the user's requested quantity can not be fulfilled, set a flash error
    unless update_qty == requested_qty
      flash[:item_error] = "Sorry, not enough stock. Your shopping basket has been adjusted accordingly."
    end

    # Save the line_item update
    current_item.update quantity: update_qty

    # Redirect to My Basket page
    redirect_to cart_path
  end

  # Remove item from My Basket page
  def destroy
    line_item = LineItem.find params[:id]
    line_item.destroy

    redirect_to cart_path
  end
end
