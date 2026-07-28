class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: [ :new, :create ]
  before_action :redirect_if_authenticated, only: [ :new, :create ]

  def new
    @user = User.new
  end

  def create
    respond_to do |format|

      if params[:user][:email].blank? || params[:user][:password].blank?
        flash.now[:alert] = "Email and password cannot be blank"
      else
        @user = User.find_by(email: params[:user][:email].downcase)
        if @user.present? && @user.authenticate(params[:user][:password])
        session[:user_id] = @user.id
        token = JsonWebToken.encode(user_id: @user.id)
        format.html { redirect_to dashboard_path, flash: { success: "Logged in successfully" }; return; }
        format.json { render json: { message: "Sign up Successfully" , token: token}}
        else
          flash.now[:alert] = "Invalid email or password"
        end
      end
      @user ||= User.new
      format.html { render :new, status: :unprocessable_entity }
      format.json { render json: { message: "#{alert}" }}
    end
  end

  def destroy
    reset_session
    respond_to do |format|
      format.html { redirect_to new_session_path, notice: "Logged out successfully." }
      format.json { render json: { message: "Log out successfully"}}
    end
  end
end
