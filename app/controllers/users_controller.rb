class UsersController < ApplicationController
  layout "sessions", only: [:new]
  include Sharable

  skip_before_action :authenticate_user, only: [:new, :create]
  before_action :redirect_if_authenticated, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        success = "Account Created Successfully"
        token = JsonWebToken.encode(user_id: @user.id)

        format.html do
          cookies.encrypted[:user_id] = @user.id

          redirect_to new_session_path, success
        end

        format.json do
          render json: {
            token: token,
            message: success
          }, status: :created
        end
      else
        flash.now[:error] = @user.errors.full_messages

        format.html do
          render :new, status: :unprocessable_entity
        end

        format.json do
          render json: {
            message: @user.errors.full_messages
          }, status: :unprocessable_entity
        end
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if current_user.update(user_params)
        alert = "Updated Successfully"

        format.html do
          redirect_to user_path(current_user)
        end

        format.json do
          render json: {
            message: alert
          }
        end
      else
        error = current_user.errors.full_messages

        format.html do
          render :edit, status: :unprocessable_entity
        end

        format.json do
          render json: {
            message: error
          }, status: :unprocessable_entity
        end
      end
    end
  end

  private

  def user_params
    params.require(root_key).permit(
      :name,
      :email,
      :password,
      :contact_number,
      :specialization_id,
      :dob,
      :type
    )
  end
end

#another message
