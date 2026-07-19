class DoctorsController < ApplicationController
  def index
    # byebug
    @doctors = Doctor.all
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
