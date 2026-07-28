class UsersController < ApplicationController
  skip_before_action :authenticate_user, only: [ :new, :create ]

  layout "sessions", only: [ :new ]
  include Sharable

  skip_before_action :authenticate_user, only: [ :new, :create ]
  before_action :redirect_if_authenticated, only: [ :new, :create ]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    respond_to do |format|
      if @user.save
        success = "Account Created Successfully"
        token = JsonWebToken.encode(user_id: @user.id)
        format.html { redirect_to new_session_path, success }
        format.json { render json: { token: token,   message: success } }  
      else
        flash.now[:error] = @user.errors.full_messages
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: { message:  @user.errors.full_messages } }
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
        format.html { redirect_to user_path(current_user) }
        format.json { render json: { message: alert }}
      else
        error = current_user.errors.full_messages
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: { message: error }}
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

#doctor login token
#eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE3ODUzMzA1NTl9.ths-P6UUulVfLJJzjHBeXQiEKQFt7pGAjEy5WVgzQzg

#patient login token
#eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJleHAiOjE3ODUzMzM1MzV9.Ul8aK4DUPJoGVvOmSs5Bndpsc6d34j0uPdLQLi9Neh0
