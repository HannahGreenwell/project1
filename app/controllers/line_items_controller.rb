class LineItemsController < ApplicationController

  def create
    line_item = LineItem.create product_id: params[:product_id], cart_id: @current_user.cart.id

    if line_item.persisted?
      redirect_to cart_path(@current_user.cart)
    else
      redirect_to products_path
    end

  end

  def update
  end

  def destroy
  end
end
