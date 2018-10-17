class AddStripeFieldsToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :stripe_token, :text
    add_column :orders, :stripe_charge_response, :json
  end
end
