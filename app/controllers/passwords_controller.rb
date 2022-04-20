class PasswordsController < ApplicationController
	def forgot_password
    if params[:email_id].blank?
      return render json: {error: "Email ID is not present"}
    end

    user = User.find_by(email_id: params[:email_id])

    if user.present?
      user.generate_password_token!
      # SEND EMAIL HERE
      render json: {status: "ok"}, status: :ok
    else
      render json: {error: ["Email address not found. Please check and try again."]}, status: :not_found
    end
  end

  def reset_password
    token = params[:token].to_s

    if params[:email_id].blank?
      return render json: {error: "Token is not present"}
    end

    user = User.find_by(reset_password_token: token)

    if user.present? && user.password_token_valid?
      if user.reset_password!(params[:password])
        render json: {status: "ok"}, status: :ok
      else
        render json: {error: user.errors.full_messages}, status: :unprocessable_entity
      end
    else
      render json: {error:  ["Link not valid or expired. Try generating a new link."]}, status: :not_found
    end
  end
end
