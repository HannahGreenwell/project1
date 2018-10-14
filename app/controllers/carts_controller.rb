class CartsController < ApplicationController
  def create
    ### Linked to 'users#create'?
  end

  def show
    @cart = Cart.find params[:id] ### Use @current_user.cart.id instead?
  end

  def destroy
    ### Linked to 'users#destroy'?
  end
end
