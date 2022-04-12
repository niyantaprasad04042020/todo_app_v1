class UserMailer < ApplicationMailer
  default from: "niyantasimplycoach@gmail.com"
 
  def signup_confirmation(user)
    @user = user
    
    mail to: user.email_id, subject: "Sign Up Confirmation"
  end
end
