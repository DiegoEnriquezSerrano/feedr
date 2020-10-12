class CaterersController < ApplicationController
  def index
    @caterers = User.where(caterer_user: true)
    render json: @caterers.as_json(only: [:id, :caterer_business_name])
  end
end
