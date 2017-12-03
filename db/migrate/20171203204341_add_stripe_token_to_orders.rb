class AddStripeTokenToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :stripe_token, :string
  end
end
