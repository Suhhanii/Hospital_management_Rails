class DoctorsController < ApplicationController
  def index
    @appointments = Doctor.find(session[:user_id]).appointments
    # byebug
  end

  def show
  end

  def delete
  end

  def edit
  end

  def new
  end
end
