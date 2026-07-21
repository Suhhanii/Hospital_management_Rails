class UsersController < ApplicationController
  skip_before_action :authenticate_user, only: [:new, :create]
  before_action :redirect_if_authenticated, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    # byebug
    # @user = User.new(name: params[:user][:name], email: params[:user][:email], password_digest: params[:user][:password], contact_number: params[:user][:contact], type: params[:type])

    @user = User.new(user_params)
    # byebug
    if params[:type] == "Patient"
     @user.dob = params[:user][:dob]
     @user = @user.becomes!(Patient)
    else
      @user.specialization_id = params[:user][:specialization_id]
      @user.status = true
      @user = @user.becomes!(Doctor)
    end

    if @user.save
      flash[:alert] = "Account Created Successfully"
      redirect_to new_session_path
    else
      flash.now[:error] = @user.errors.full_messages
      # byebug
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(
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
