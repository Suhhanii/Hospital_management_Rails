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
    respond_to do |format|
      format.html
      format.json { render json: @working_hour }
    end
  end

  def update
    status = if @working_hour.update(working_hour_params)
      "Updated Successfully"
    else
      @working_hour.errors.full_messages
    end
    flash[:alert] = status
    respond_to do |format|
      format.html { redirect_to working_hours_path, alert: status }
      format.json { render json: { message: status } }
    end
  end

  def create
    # byebug
    @working_hour = current_user.working_hours.new(working_hour_params)
    if @working_hour.save
      status = "Working Hour Created Successfully"
    else
      status = @working_hour.errors.full_messages
    end
    # flash[:alert] = status
    respond_to do |format|
      format.html { redirect_to working_hours_path, alert: status }
      format.json { render json: { message: status } }
    end 
  end

  def new
    @working_hour = WorkingHour.new
  end

  def destroy
    status = if @working_hour.destroy
      "Working Hour Deleted Successfully"
    else
      @working_hour.errors.full_messages
    end
    flash[:alert] = status
    respond_to do |format|
      format.html { redirect_to working_hours_path, alert: status }
      format.json { render json: {message: status} }
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
