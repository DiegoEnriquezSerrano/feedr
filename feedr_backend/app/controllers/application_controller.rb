class ApplicationController < ActionController::API
  include ::ActionController::Cookies

  def current_order
    if !authenticate_user.nil?
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
    else
      head(:not_found)
    end
  end

  private
  def authenticate_user
    jwt = cookies.signed[:jwt]
    return if jwt.nil?
    JWT.decode( jwt, ENV['DEVISE_JWT_SECRET_KEY'] )
    rescue JWT::ExpiredSignature
      nil
    rescue JWT::DecodeError
      nil
  end
end
