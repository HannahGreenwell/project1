class CartsController < ApplicationController
  def create
  end

  def show
    @cart = Cart.find params[:id]
  end

  def edit
  end

  def update
  end
end
