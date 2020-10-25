private
def authenticate_user
  jwt = cookies.signed[:jwt]
  JWT.decode( jwt, ENV['DEVISE_JWT_SECRET_KEY'] )
  rescue ::JWT::ExpiredSignature
    fail "Auth token has expired"
  rescue ::JWT::DecodeError
    fail "Auth token is invalid"
end