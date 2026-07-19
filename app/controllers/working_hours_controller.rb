class WorkingHoursController < ApplicationController
  def index
    # byebug
    @working_hours = current_user.working_hours
  end

  def edit
  end
end
