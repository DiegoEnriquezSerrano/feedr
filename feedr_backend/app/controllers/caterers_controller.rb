class CaterersController < ApplicationController
  before_action :authenticate_user, only: [:search]

  def index
    @caterers = User.where(caterer_user: true)
    render json: @caterers.as_json(only: [:id, :caterer_business_name])
  end

  def search
    header = JWT.decode(cookies.signed[:jwt], ENV['DEVISE_JWT_SECRET_KEY'] )
    @user = User.find(header[0]['user_id'])
    render json: { user: @user.as_json(only: [:id, :first_name, :caterer_user]) }
  end
end
