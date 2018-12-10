class OrdersController < ApplicationController

  before_action :fetch_cart_and_check_inventory, except: [:show]

  # User routed here from click on 'Checkout' button on My Basket page (carts#user_cart)
  def create
    # Invokes action in cart.rb that checks whether the cart is empty
    if @cart.is_cart_empty?
      # If the cart is empty, set flash error and redirect to My Basket page
      flash[:item_error] = "Your cart is empty."
      redirect_to cart_path
      return
    end

    # Create order and redirect to orders#confirm_order
    @order = Order.create user_id: @current_user.id
    redirect_to confirm_order_path
  end

  # User routed here after creating new order
  def confirm_order
  end

  # User routed here after clicking on Stripe's 'Pay with Card'
  # button on orders#confirm_order and then completing the payment
  # form within the Stripe Checkout window
  # Note: Checkout sends the payment details directly to Stripe from
  # the customer's browser, assuming the details pass basic validation
  def payment
    # Get the current user's last order (i.e. the current order)
    @order = @current_user.orders.last

    # Token automatically created by Checkout and sent through params
    token = params[:stripeToken]

    # Invoke action in cart.rb that calculates the total price of all items in the cart
    total_amount = (@cart.get_total_price * 100).to_i

    Stripe.api_key = Rails.application.secrets.stripe_api_secret

    # Make an API request to create a one-time charge containing the token,
    # currency, total amount (as an integer not a float) and description
    charge = Stripe::Charge.create({
    amount: total_amount,
    currency: 'aud',
    description: 'Purchase from Eight by Eight',
    source: token,
    })

    # Update the current order with the Stripe charge response data
    @order.update stripe_token: token, stripe_charge_response: charge

    # Checks whether the payment was successful
    unless @order.stripe_charge_response["outcome"]["network_status"] == "approved_by_network"
      # If the payment was unsuccessful, set a flash error and redirect to orders#confirm_order
      flash[:order_error] = "Transaction unsuccessful. Please contact your card issuer for more details."
      redirect_to confirm_order_path
      return
    end

    # Redirect to orders#complete_order
    redirect_to complete_order_path
  end

  # User routed here after successful payment
  def complete_order
    # Get the current user's last order (i.e. the current order)
    @order = @current_user.orders.last

    # Invoke an action in order.rb that 'moves' items from a user's cart to the current order
    @order.add_line_items_from_cart @cart

    # Invoke action in order.rb that updates stock levels
    @order.update_inventory

    # Destroy the user's cart
    @cart.destroy

    # Set a flash notification that the order was successful
    flash[:notification] = "Order successful!!!"

    # Redirect to orders#show
    redirect_to order_path(@order)
  end

  def show
    @order = Order.find params[:id]
  end
end
