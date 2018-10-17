class OrdersController < ApplicationController

  before_action :get_cart, only: [:confirm_order, :complete_order]

  def create
    @order = Order.create user_id: @current_user.id
    redirect_to confirm_order_path
  end

  def confirm_order
  end

  def initiate_payment
    @order = @current_user.orders.last

    token = params[:stripeToken]
    @order.update stripe_token: token

    Stripe.api_key =  Rails.application.secrets.stripe_api_secret
    puts "###############"
    puts Stripe.api_key

    charge = Stripe::Charge.create({
    amount: 999,
    currency: 'aud',
    description: 'Example charge',
    source: token,
    })

    @order.update stripe_charge_response: charge

    unless @order.stripe_charge_response["outcome"]["network_status"] == "approved_by_network"
      ### Failed Payments
    end

    redirect_to complete_order_path
  end

  def complete_order
    @order = @current_user.orders.last
    @order.add_line_items_from_cart @cart

    redirect_to order_path(@order)
    # if @order.save
    #   @cart.destroy
    #   redirect_to order_path(@order)
    # else
    #   flash[:errors] = @order.errors.full_messages
    #   redirect_to cart_path
    # end
  end

  def show
    @order = Order.find params[:id]
  end

  private

  def ensure_cart_isnt_empty
    # Does site need?
  end

  def get_cart
    @cart = Cart.fetch_or_create_for_user @current_user
  end
end
