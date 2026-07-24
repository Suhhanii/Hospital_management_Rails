class AppointmentsController < ApplicationController
  before_action :find_appointment, only: [ :appointment_show, :edit, :update ]

  ALLOWED_VALUES = {
    "filter": %w[ scheduled completed canceled],
    "type": %w[ today upcoming past ]
  }

  def index
    @appointments = current_user.appointments
    @appointments = @appointments.send(params[:type]) if valid_values?(:type, params)
    @appointments = @appointments.send(params[:filter]) if valid_values?(:filter, params)
  end

  def appointment_show
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
      status = current_user.appointments.last.errors.full_messages
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
    @appointment = current_user.appointments.find(params[:id])
  end

  def appointments_params
    params.require(:appointment).permit(
    :appointment_at,
    :doctor_id
    )
  end

  def valid_values?(key, value)
    ALLOWED_VALUES[key].include?(value)
  end
end
