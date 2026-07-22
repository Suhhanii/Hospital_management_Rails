class AppointmentsController < ApplicationController

  before_action :find_appointment, only:[:show, :edit, :update]

  def index
    @appointments = current_user.appointments.send(params[:filter])

    @scheduled = @appointments.scheduled
    @canceled = @appointments.canceled
    @completed = @appointments.completed
    @status = params[:filter]
  end

  def show
  end

  def delete
  end

  def edit
    @action_type = params[:action_type]
  end

  def new
  end

  def update
    # byebug
    case params[:action_type]
    when "reschedule"
      current_user.appointments.find(params[:id]).reschedule_appointment(params[:appointment][:appointment_at])
    else
      @appointment.update(status: params[:action_type])
    end

    redirect_to root_path, notice: "Appointment #{params[:action_type]}"
  end

  private

  def find_appointment
    @appointment = Appointment.find(params[:id])
  end
end
