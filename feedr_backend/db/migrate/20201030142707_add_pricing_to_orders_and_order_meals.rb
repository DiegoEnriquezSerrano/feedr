class AddPricingToOrdersAndOrderMeals < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :subtotal, :decimal
    add_column :order_meals, :unit_price, :decimal
  end
end
