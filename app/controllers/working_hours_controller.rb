class WorkingHoursController < ApplicationController
  def index
    # byebug
    @working_hours = current_user.working_hours
  end

  def edit
  end

  def show
    # byebug
    @working_hour = WorkingHour.find(params[:id])
  end

  def new
    @working_hour = WorkingHour.new
  end
end
