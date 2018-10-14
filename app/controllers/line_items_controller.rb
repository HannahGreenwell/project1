class LineItemsController < ApplicationController

  def create
    line_item = LineItem.find_by product_id: params[:product_id], cart_id: @current_user.cart.id

    # Check whether the user has already added the item to their cart,
    # and if they have increase the quantity by 1, otherwise create
    # a new line_item
    if line_item.present?
      new_quantity = line_item.quantity + 1
      line_item.update quantity: new_quantity
    else
      LineItem.create product_id: params[:product_id], cart_id: @current_user.cart.id
    end

    redirect_to cart_path(@current_user.cart)
  end

  def update
    ### TIER 2
  end

  def destroy
    line_item = LineItem.find params[:id]
    line_item.destroy

    redirect_to cart_path(@current_user.cart)
  end
end
