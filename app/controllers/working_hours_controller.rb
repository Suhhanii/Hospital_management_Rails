class WorkingHoursController < ApplicationController
  before_action :find_working_hour, only: [ :show, :destroy, :edit, :update ]

  def index
    @working_hours = current_user.working_hours.order(:day_of_week)

    respond_to do |format|
      format.html
      format.json { render json: @working_hours }
    end 
  end

  def edit
  end

  def show
    byebug
    respond_to do |format|
      format.html
      format.json { render json: @working_hour }
    end
  end

  def update
    alert_message = if @working_hour.update(working_hour_params)
      "Updated Successfully"
    else
      @working_hour.errors.full_messages
    end

    respond_to do |format|
      format.html { redirect_to working_hours_path, alert: alert_message }
      format.json { render json: { message: alert_message }}
    end
  end

  def create
    @working_hour = current_user.working_hours.new(working_hour_params)
    alert_message = if @working_hour.save
      "Working Hour Created Successfully"
    else
      @working_hour.errors.full_messages
    end

    respond_to do |format|
      format.html { redirect_to working_hours_path, alert: alert_message }
      format.json { render json: { message: alert_message }}
    end 
  end

  def new
    @working_hour = WorkingHour.new
  end

  def destroy
    alert_message = if @working_hour.destroy
      "Working Hour Deleted Successfully"
    else
      @working_hour.errors.full_messages
    end

    respond_to do |format|
      format.html { redirect_to working_hours_path, alert: alert_message }
      format.json { render json: {message: alert_message }}
    end
  end

  private

  def find_working_hour
    @working_hour = current_user.working_hours.find(params[:id])
  end

  def working_hour_params
    params.require(:working_hour).permit(
      :day_of_week,
      :start_time,
      :end_time
    )
  end
end
