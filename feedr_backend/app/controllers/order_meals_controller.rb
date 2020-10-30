class OrderMealsController < ApplicationController

  def create
    @order = current_order
    @order_meal = @order.order_meals.new(order_params)
    meal_caterer = Meal.find(order_params[:meal_id]).user_id
    @order.caterer_id = meal_caterer
    @order.save
    render json: @order.as_json
  end

  private
  def order_params
    params.required(:order_meal).permit(:meal_id, :total_servings)
  end
end
