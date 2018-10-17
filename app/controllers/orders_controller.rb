class OrdersController < ApplicationController

  before_action :fetch_cart, only: [:confirm_order, :payment, :complete_order]

  def create
    @order = Order.create user_id: @current_user.id
    redirect_to confirm_order_path
  end

  def confirm_order
  end

  def payment
    @order = @current_user.orders.last

    token = params[:stripeToken]

    Stripe.api_key =  Rails.application.secrets.stripe_api_secret

    charge = Stripe::Charge.create({
    amount: @cart.get_total_price * 100,
    currency: 'aud',
    description: 'Example charge',
    source: token,
    })

    @order.update stripe_token: token, stripe_charge_response: charge

    unless @order.stripe_charge_response["outcome"]["network_status"] == "approved_by_network"
      ### Failed Payments
    end

    redirect_to complete_order_path
  end

  def complete_order
    @order = @current_user.orders.last
    @order.add_line_items_from_cart @cart
    @cart.destroy

    redirect_to order_path(@order)
  end

  def show
    @order = Order.find params[:id]
  end
end
