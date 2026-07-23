class AppointmentsController < ApplicationController
  before_action :find_appointment, only: [ :show, :edit, :update ]

  def index
    @appointments = current_user.appointments
    @appointments = @appointments.send(params[:type]) if params[:type].present?
    @appointments = @appointments.send(params[:filter]) if params[:filter].present?
    # byebug
  end

  def show
  end

  def delete
  end

  def edit
    @action_type = params[:action_type]
  end

  def new
    @appointment = Appointment.new
  end

  def create
    if current_user.appointments.create(appointments_params)
      status = "Appointment Book Successfully"
    else
      status = current_user.errors.full_messages
    end
    flash[:alert] = status
    redirect_to appointments_path
  end

  def update
    case params[:action_type]
    when "reschedule"
      current_user.appointments.find(params[:id]).reschedule_appointment(params[:appointment][:appointment_at])
    else
      @appointment.update(status: params[:action_type])
    end

    redirect_to appointments_path, alert: "Appointment #{params[:action_type]}"
  end

  private

  def find_appointment
    @appointment = Appointment.find(params[:id])
  end

  def appointments_params
    params.require(:appointment).permit(
    :appointment_at,
    :doctor_id
    )
  end
end
