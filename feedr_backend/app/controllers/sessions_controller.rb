class SessionsController < Devise::SessionsController
  respond_to :json

  def create
    @user = User.where(email: params[:email]).first

    if @user&.valid_password?(params[:password])
      jwt = JWT.encode( { user_id: @user.id, exp: (Time.now + 2.weeks).to_i }, ENV['DEVISE_SECRET_KEY'], 'HS256' )
      render json: { token: jwt, email: @user.email, first_name: @user.first_name, caterer: @user.caterer_user }, status: :created
    else
      head(:unauthorized)
    end
  end

  private
  def respond_with(resource, _opts = {})
      render json: resource
  end
    
  def respond_to_on_destroy
    head :ok
  end
end
