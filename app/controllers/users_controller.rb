class UsersController < ApplicationController
  include Sharable

  skip_before_action :authenticate_user, only: [:new, :create]
  before_action :redirect_if_authenticated, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:alert] = "Account Created Successfully"
      redirect_to new_session_path
    else
      flash.now[:error] = @user.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if current_user.update(user_params)
      flash[:alert] = "Updated Successfully"
      redirect_to user_path(current_user)
    else
      # byebug
      flash.now[:error] = current_user.errors.full_messages
      render :edit, status: :unprocessable_entity
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
