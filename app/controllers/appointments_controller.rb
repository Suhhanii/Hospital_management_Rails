class AppointmentsController < ApplicationController
  def index
    # byebug
  end

  def show
    @app = Appointment.find(params[:format])
  end

  def delete
  end

  def edit
  end

  def new
  end
end
