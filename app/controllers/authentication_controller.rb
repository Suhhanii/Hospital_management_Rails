class AuthenticationController < ApplicationController
  def create
    # byebug
    user = User.find_by(email: params[:email], password: params[:password])

    if user
      session[:user_id] = user.id

      if user.is_a?(Doctor)
        session[:doctor_name] = user.name
        redirect_to "/doctors/dashboard"
      else
        session[:patient_name] = user.name
        redirect_to "/patients/dashboard"
      end
    else
      # flash[:alert] = "Wrong email or password try again"
      render :new, alert: "Wrong email or password try again"
    end
  end

  def sign_up
  end

  def sign_out
  end
end
