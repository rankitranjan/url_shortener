class Api::V1::ApiController < ApplicationController
	protect_from_forgery with: :null_session, only: Proc.new { |c| c.request.format.json? }
  before_filter :varify_auth_header
  before_filter :authenticate, if: :varify_auth_header
	# before_filter :check_authorization

  def varify_auth_header
  	return request.headers['Authorization'].present?
  end

  def authenticate
    authenticate_or_request_with_http_token do |token, options|
      user = User.where(email: options[:email]).first
      if user && ActiveSupport::SecurityUtils.secure_compare(user.auth_token, token)
        @current_user = user
      else
        return head status: :unauthorized
      end
    end
  end

  def current_user
    @current_user
  end

  def check_authorization
    if params[:id]
      model = params[:controller].split("/").last.classify.constantize
      resource = model.find(params[:id])
      unless current_user.id == resource.user_id
        render :json => {success: false, :errors => "You are not allowed"}, :status => 401
      end
    else
      return true
    end
  end

end

# Token token=jGYf5zfrDZRF_Fu4HcLzz4LNUWuQsaMXew;email=rankit4u@gmail.com