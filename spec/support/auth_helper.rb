module AuthHelper
  def http_login(user)
    token = user.auth_token
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(token)
  end
end