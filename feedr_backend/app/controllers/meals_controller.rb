class MealsController < ApplicationController
  def index
    @meals = Meal.where(user_id: params[:caterer])
    render json: @meals.as_json(except: [
      :created_at,
      :updated_at,
      :user_id
    ])
  end
end
