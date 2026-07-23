class WorkingHoursController < ApplicationController
  before_action :find_working_hour, only: [ :show, :destroy, :edit, :update ]

  def index
    @working_hours = current_user.working_hours.order(:day_of_week)
  end

  def edit
  end

  def show
  end

  def update
    if @working_hour.update(working_hour_params)
      status = "Updated Successfully"
    else
      status = @working_hour.errors.full_messages
    end
    flash[:alert] = status
    redirect_to working_hours_path
  end

  def create
    # byebug
    if current_user.working_hours << WorkingHour.create(working_hour_params)
      status = "Working Hour Created Successfully"
    else
      status = current_user.errors.full_messages
    end
    flash[:alert] = status
    redirect_to working_hours_path
  end

  def new
    @working_hour = WorkingHour.new
  end

  def destroy
    if @working_hour.destroy
      status = "Working Hour Deleted Successfully"
    else
      status = @working_hour.errors.full_messages
    end
    flash[:alert] = status
    redirect_to working_hours_path
  end

  private

  def find_working_hour
    @working_hour = WorkingHour.find(params[:id])
  end

  def working_hour_params
    params.require(:working_hour).permit(
      :day_of_week,
      :start_time,
      :end_time
    )
  end
end
