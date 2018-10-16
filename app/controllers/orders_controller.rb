class OrdersController < ApplicationController

  before_action :get_cart, only: [:create]

  def new
    @order = Order.new
  end

  def create
    @order = Order.new order_params
    @order.add_line_items_from_cart @cart

    if @order.save
      @cart.destroy
      redirect_to order_path(@order)
    else
      flash[:errors] = @order.errors.full_messages
      render :new
    end
  end

  def index
  end

  def show
  end

  private

  def ensure_cart_isnt_empty
    # Does site need?
  end

  def order_params
    params.require(:order).permit(:name, :address)
  end

  def get_cart
    @cart = Cart.fetch_or_create_for_user @current_user
  end
end
