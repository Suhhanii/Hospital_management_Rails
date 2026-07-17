class AuthenticationController < ApplicationController
  def create
    user = User.find_by(email: params[:email], password: params[:password])

    # byebug
    reset_session if session[:user_id] || session[:patient_name] || session[:patient_name]

    if user
      session[:user_id] = user.id

      if user.is_a?(Doctor)
        session[:doctor_name] = user.name
        redirect_to "/dashboard", status: :see_other
      else
        session[:patient_name] = user.name
        redirect_to "/dashboard", status: :see_other
      end
    else
      # flash[:alert] = "Wrong email or password try again"
      render :new, alert: "Wrong email or password try again"
    end
  end

  def sign_up
  end

  def destroy
    reset_session
    redirect_to root_path
  end
end
