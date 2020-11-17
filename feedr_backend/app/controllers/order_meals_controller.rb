class OrderMealsController < ApplicationController

  def create
    if !authenticate_user.nil?
      @order = current_order
      @meal = Meal.find(order_params[:meal_id])
      if @order.caterer_id.nil?
        @order.caterer_id = @meal.user_id
      end
      @order_meal = OrderMeal.find_by(order: @order.id, meal: @meal.id) || @order.order_meals.new(order_params)
      @order_meal.total_servings = order_params[:total_servings]
      if @order.save && @order_meal.save
        render json: @order.as_json, status: :created
      else
        render json: { errors: @order_meal.errors || @order.errors }, status: :forbidden
      end
    else
      render json: { errors: 'Must be logged in' }, status: :unauthorized
    end
  end

  private
  def order_params
    params.required(:order_meal).permit(:meal_id, :total_servings)
  end
end
