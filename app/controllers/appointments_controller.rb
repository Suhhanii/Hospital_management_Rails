class AppointmentsController < ApplicationController
  def index
    if session[:doctor_name]
        @doc = Doctor.find(session[:user_id])
        @a = @doc.appointments
        @today_schedule_app = @a.todays_appointments("scheduled")
        @today_cancel_app = @a.todays_appointments("canceled")
        @today_completed_app = @a.todays_appointments("completed")
        # byebug
    else

    end
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
