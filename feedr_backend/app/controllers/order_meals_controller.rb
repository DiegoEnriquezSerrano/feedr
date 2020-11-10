class OrderMealsController < ApplicationController

  def create
    @order = current_order
    @meal = Meal.find(order_params[:meal_id])
    if @order.caterer_id.nil?
      @order.caterer_id = @meal.user_id
    end
    if !@order.order_meals.where(meal_id: order_params[:meal_id]).empty?
      @order_meal = OrderMeal.where(order_id: @order.id).where(meal_id: order_params[:meal_id]).last
    else
      @order_meal = @order.order_meals.new(order_params)
    end
    @order_meal.total_servings = order_params[:total_servings]
    @order.updated_at = Time.now
    if @order.save && @order_meal.save
      render json: @order.as_json
    else 
      render json: { errors: @order_meal.errors || @order.errors }, status: :forbidden
    end
  end

  private
  def order_params
    params.required(:order_meal).permit(:meal_id, :total_servings)
  end
end
