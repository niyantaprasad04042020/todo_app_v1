class UsersController < ApplicationController
  before_action :authorized, only: [:auto_login]

  # REGISTER
  def signup
    @user = User.create(user_params)
    if @user.valid?
      UserMailer.welcome_email(@user).deliver_now
      token = encode_token({user_id: @user.id})
      render json: {user: @user, token: token}
    else
      render json: {error: "Invalid username or password"}
    end
  end

  # LOGGING IN
  def login
    @user = User.find_by(email_id: params[:email_id])

    if @user && @user.authenticate(params[:password])
      token = encode_token({user_id: @user.id})
      render json: {user: @user, token: token}
    else
      render json: {error: "Invalid username or password"}
    end
  end


  def auto_login
    render json: @user
  end

  private

  def user_params
    params.permit(:first_name, :last_name, :email_id, :phone_no, :password)
  end
end
