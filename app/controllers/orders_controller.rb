class OrdersController < ApplicationController

  before_action :fetch_cart_and_check_inventory, only: [:confirm_order, :payment, :complete_order]

  def create
    @order = Order.create user_id: @current_user.id
    redirect_to confirm_order_path
  end

  def confirm_order
  end

  def payment
    @order = @current_user.orders.last

    token = params[:stripeToken]
    total_amount = (@cart.get_total_price * 100).to_i

    Stripe.api_key =  Rails.application.secrets.stripe_api_secret

    charge = Stripe::Charge.create({
    amount: total_amount,
    currency: 'aud',
    description: 'Example charge',
    source: token,
    })

    @order.update stripe_token: token, stripe_charge_response: charge

    unless @order.stripe_charge_response["outcome"]["network_status"] == "approved_by_network"
      flash[:error] = "Transaction unsuccessful. Please contact your card issuer for more details."
      redirect_to confirm_order_path
      return
    end

    redirect_to complete_order_path
  end

  def complete_order
    @order = @current_user.orders.last
    @order.add_line_items_from_cart @cart
    @order.update_inventory
    @cart.destroy

    flash[:notification] = "Order successfully completed!"

    redirect_to order_path(@order)
  end

  def show
    @order = Order.find params[:id]
  end
end
