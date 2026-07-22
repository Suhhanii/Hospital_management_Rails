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
    # byebug
    @app = Appointment.find(params[:id])
  end

  def delete
  end

  def edit
    @appointment = Appointment.find(params[:id])
    @action_type = params[:action_type]
  end

  def new
  end

  def update
    @appointment = Appointment.find(params[:id])

    case params[:action_type]
    when "cancel"
      @appointment.update(status: "canceled")
      redirect_to @appointment, notice: "Appointment cancelled."

    when "complete"
      @appointment.update(status: "completed")
      redirect_to @appointment, notice: "Appointment completed."

    when "reschedule"
      @appointment.update(appointment_at: params[:appointment][:appointment_at])
      redirect_to @appointment, notice: "Appointment rescheduled."
    end
  end
end
