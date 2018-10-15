class LineItemsController < ApplicationController

  before_action :check_if_logged_in
  before_action :get_cart, except: [:destroy]

  def create

    # Check if the user already has the item in their cart
    current_item = LineItem.find_by product_size_id: params[:product_size_id], cart_id: @cart.id

    # If the item is already in the user's cart, increment the quantity
    # If the item is not in the user's cart create a new line_item record
    if current_item.present?
      current_item.quantity += 1
    else
      current_item = LineItem.new product_size_id: params[:product_size_id], cart_id: @cart.id
    end

    current_item.save
    redirect_to cart_path
  end

  def update
    current_item = LineItem.find params[:id]

    # Check for users trying to update line items that don't belong to their cart
    unless @cart.line_items.include?(current_item)
      redirect_to cart_path
      return
    end

    new_qty = params[:quantity].to_i

    ### CHECK QUANTITY ###
    if current_item.product_size.quantity < new_qty
      puts '#################################################'
      puts 'NOT ENOUGH STOCK'
      puts "SOH: #{current_item.product_size.quantity}"
      puts "Requested: #{params[:quantity]}"
      puts '#################################################'
      flash[:error] = "..."
      new_qty = current_item.product_size.quantity
    end

    if current_item.update quantity: new_qty
      redirect_to cart_path
    else
      flash[:errors] = @current_item.errors.full_messages
      redirect_to cart_path
    end
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
