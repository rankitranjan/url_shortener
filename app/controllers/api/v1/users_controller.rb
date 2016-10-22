class Api::V1::UsersController < Api::V1::ApiController
  before_action :authenticate, only: [:logout, :update, :destroy]

  layout false
  respond_to :json

  def index
    @users = User.all
    respond_with(@users)
  end

  def registration
    @user = User.new(user_params)
    @user.ensure_authentication_token!
      if @user.save
       render json: {success: true, status: 200, name: @user.name, email: @user.email, authentication_token: @user.auth_token}
      else
       render :json => {success: false, :errors => @user.errors.to_a.uniq.join(", ")}, :status => 200
      end
  end

  def login
    @user = User.find_by_email(user_params[:email])
    if @user && @user.is_password?(user_params[:password])
      @user.ensure_authentication_token!
      render :json => { success: true, status: 200, name: @user.name, email: @user.email, :auth_token => @user.auth_token}
    else
      render json: { success: false, message: 'Error with your login or password' }, status: 401
    end
  end

  def logout
    if current_user
      current_user.update({auth_token: current_user.reset_authentication_token!})
      render :json => {:message => 'Successfully signed out!' }, :success => true, :status => 200 and return
    else
      render :json => {:message => 'Invalid token.' }, :status => 404 and return
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :confirm_password)
    end
end
