class AppointmentsController < ApplicationController
  def index
        # @doc = Doctor.find(session[:user_id])
        # @a = @doc.appointments
        # @today_schedule_app = @a.todays_appointments("scheduled")
        # @today_cancel_app = @a.todays_appointments("canceled")
        # @today_completed_app = @a.todays_appointments("completed")
        # byebug
        @appointments = current_user.appointments
        case params[:filter]
        when "today"
          @appointments = @appointments.where(appointment_at: Date.today.all_day)
        when "upcoming"
          @appointments = @appointments.where("appointment_at > ?",Date.tomorrow)
        when "past"
          @appointments = @appointments.where("appointment_at < ?",Date.today)
        end
        @scheduled = @appointments.scheduled
        @canceled = @appointments.canceled
        @completed = @appointments.completed
        @status = params[:filter]
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
