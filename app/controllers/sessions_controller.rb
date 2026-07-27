class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: [ :new, :create ]
  before_action :redirect_if_authenticated, only: [ :new, :create ]

  def new
    @user = User.new
  end

  def create
    # byebug
    if params[:user][:email].blank? || params[:user][:password].blank?
      flash.now[:alert] = "Email and password cannot be blank"
    else
      @user = User.find_by(email: params[:user][:email].downcase)
      # byebug
      if @user.present? && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect_to dashboard_path, flash: { success: "Logged in successfully" }; return;
      else
        flash.now[:alert] = "Invalid email or password"
      end
    end
    @user ||= User.new
    render :new, status: :unprocessable_entity
    # byebug
    # @user = User.find_by(email: params[:user][:email])
    # if @user.present? && @user.authenticate(params[:user][:password])
    #   session[:user_id] = @user.id
    #   redirect_to dashboard_path, flash: { success: "Logged in successfully" }
    # else
    #   flash.now[:alert] = "Invalid email or password"
    #   render :new, status: :unprocessable_entity
    # end
  end

  def destroy
    reset_session
    redirect_to new_session_path, notice: "Logged out successfully."
  end
end