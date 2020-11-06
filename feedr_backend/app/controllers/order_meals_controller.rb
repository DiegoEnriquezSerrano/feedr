class OrderMealsController < ApplicationController

  def create
    @order = current_order
    meal_caterer = Meal.find(order_params[:meal_id]).user_id
    if @order.caterer_id.nil?
      @order.caterer_id = meal_caterer
    else
      if @order.caterer_id != meal_caterer
        render json: { error: 'Caterer conflict' }, status: :forbidden
        return
      end
    end
    if !@order.order_meals.where(meal_id: order_params[:meal_id]).empty?
      @order_meal = OrderMeal.where(order_id: @order.id).where(meal_id: order_params[:meal_id]).last
      @order_meal.update(total_servings: @order_meal.total_servings + order_params[:total_servings])
    else
      @order_meal = @order.order_meals.new(order_params)
    end
    @order.updated_at = Time.now
    @order.save
    render json: @order.as_json
  end

  private
  def order_params
    params.required(:order_meal).permit(:meal_id, :total_servings)
  end
end
