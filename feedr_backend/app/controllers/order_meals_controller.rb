class OrderMealsController < ApplicationController

  def create
    if !authenticate_user.nil?
      @order = current_order
      @order.caterer_id ||= Meal.find(order_params[:meal_id]).user_id
      @order_meal = @order.set_order_meal(order_params[:meal_id], order_params[:total_servings])
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
