class LineItemsController < ApplicationController

  before_action :check_if_logged_in
  before_action :get_cart, except: [:destroy]

  def create
    # Check if the user has already added the item to their cart
    # If the user has not already added the item to their cart, create a new line_item
    current_item = LineItem.find_or_create_by product_size_id: params[:product_size_id], cart_id: @cart.id

    requested_qty = current_item.quantity + 1  ### Change to select??

    # Check that enough stock is available
    update_qty = current_item.get_update_qty requested_qty

    # If the user's requested quantity can not be fulfilled add a flash error
    unless update_qty == requested_qty
      flash[:error] = "Sorry, not enough stock. Your shopping basket has been adjusted accordingly."
    end

    current_item.update quantity: update_qty

    redirect_to cart_path
  end

  def update
    requested_qty = params[:quantity].to_i

    # Validates user input quantity
    unless requested_qty > 0
      flash[:error] = 'Please enter a valid quantity.'
      redirect_to cart_path
      return
    end

    current_item = LineItem.find params[:id]

    # Check for users trying to update line items that don't belong to their cart
    unless @cart.line_items.include?(current_item)
      redirect_to cart_path
      return
    end

    update_qty = current_item.get_update_qty requested_qty

    # Adds a flash error if the customers requested quantity could not be fulfilled
    unless update_qty == requested_qty
      flash[:error] = "Sorry, not enough stock. Your shopping basket has been adjusted accordingly."
    end

    current_item.update quantity: update_qty

    redirect_to cart_path
    # if current_item.update quantity: new_qty
    #   redirect_to cart_path
    # else
    #   flash[:errors] = @current_item.errors.full_messages
    #   redirect_to cart_path
    # end
  end

  def destroy
    line_item = LineItem.find params[:id]
    line_item.destroy

    redirect_to cart_path
  end

  private

  def get_cart
      @cart = Cart.fetch_or_create_for_user @current_user
  end
end
