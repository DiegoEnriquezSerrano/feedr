class NewOrdersController < ApplicationController
  def show
    @order_meals = current_order.order_meals
    render json: @order_meals.as_json(
      include: { meal: { except: [
          :created_at,
          :updated_at,
          :user_id
      ]}}
    )
  end
end
