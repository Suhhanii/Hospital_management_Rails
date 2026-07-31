class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: [:new, :create]
  before_action :redirect_if_authenticated, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    respond_to do |format|

      if params[:user][:email].blank? || params[:user][:password].blank?
        flash.now[:alert] = "Email and password cannot be blank"

        format.html do
          @user = User.new
          render :new, status: :unprocessable_entity
        end

        format.json do
          render json: {
            message: "Email and password cannot be blank"
          }, status: :unprocessable_entity
        end

        next
      end

      @user = User.find_by(
        email: params[:user][:email].downcase
      )

      if @user.present? && @user.authenticate(params[:user][:password])

        token = JsonWebToken.encode(user_id: @user.id)

        format.html do
          cookies.encrypted[:user_id] = @user.id

          redirect_to dashboard_path,
                      flash: {
                        success: "Logged in successfully"
                      }
        end

        format.json do
          render json: {
            message: "Logged in successfully",
            token: token
          }, status: :ok
        end

      else
        flash.now[:alert] = "Invalid email or password"

        format.html do
          render :new, status: :unprocessable_entity
        end

        format.json do
          render json: {
            message: "Invalid email or password"
          }, status: :unauthorized
        end
      end
    end
  end

  def destroy
    respond_to do |format|
      format.html do
        cookies.delete(:user_id)

        redirect_to new_session_path,
                    notice: "Logged out successfully."
      end

      format.json do
        render json: {
          message: "Log out successfully"
        }, status: :ok
      end
    end
  end
end