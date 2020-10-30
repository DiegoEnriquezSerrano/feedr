class MealsController < ApplicationController
  def index
  end

  def show
    if Meal.find(params[:id]).exists?
      @meal = Meal.find(params[:id])
      render json: @meal.as_json
    else
      head(:not_found)
    end
  end
end
