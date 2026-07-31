class AppointmentsController < ApplicationController
  before_action :find_appointment, only: [ :show, :edit, :update ]

  ALLOWED_VALUES = {
    "filter": %w[ scheduled completed canceled],
    "type": %w[ today upcoming past ]
  }

  def index
    # byebug
    @appointments = current_user.appointments
    @appointments = @appointments.send(params[:type]) if  ?(:type, params)
    @appointments = @appointments.send(params[:filter]) if valid_values?(:filter, params)
    # byebug
    respond_to do |format|
      format.html
      format.json { render json: @appointments }
      format.any { head :not_acceptable }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: @appointment}
    end
  end

  def edit
    @action_type = params[:action_type]
  end

  def new
    @appointment = Appointment.new
  end

  def create
    @appointment = current_user.appointments.create(appointments_params)

    alert_message = if @appointment.save
      "Appointment Book Successfully"
    else
      @appointment.errors.full_messages
    end

    respond_to do |format|
      format.html { redirect_to appointments_path, alert: alert_message}
      format.json { render json: { message: alert_message } }
    end
  end

  def update
    case params[:action_type]
    when "reschedule"
      @appointment.reschedule_appointment(params[:appointment][:appointment_at])
    else
      @appointment.update(status: params[:action_type])
    end

    respond_to do |format|
      format.html { redirect_to appointments_path, alert: "Appointment #{params[:action_type]}" }
      format.json { render json: { message: "Appointment #{params[:action_type]}" }}
    end
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
