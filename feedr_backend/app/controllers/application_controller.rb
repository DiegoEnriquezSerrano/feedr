class ApplicationController < ActionController::API
  include ::ActionController::Cookies

  def current_order
    if authenticate_user
      user = User.find(authenticate_user[0]['user_id'])
      if Order.where(customer: user).where(submitted: false).where(abandoned: false).empty?
        Order.new(
          customer: user,
          caterer_id: nil,
          submitted: false,
          abandoned: false,
          submitted_on: nil,
          abandoned_on: nil
        )
      else
        Order.where(customer: user).where(submitted: false).where(abandoned: false).last
      end
    end
  end

  private
  def authenticate_user
    jwt = cookies.signed[:jwt]
    JWT.decode( jwt, ENV['DEVISE_JWT_SECRET_KEY'] )
    rescue ::JWT::ExpiredSignature
      fail "Auth token has expired"
    rescue ::JWT::DecodeError
      fail "Auth token is invalid"
  end
end
