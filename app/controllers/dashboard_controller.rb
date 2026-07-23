class DashboardController < ApplicationController
  def user_show
    if current_user.is_a?(Doctor)
      @doc = current_user

      @appointments = @doc.appointments

      @today_schedule_app = @appointments.todays_appointments("scheduled")
      @today_cancel_app   = @appointments.todays_appointments("canceled")
      @today_completed_app = @appointments.todays_appointments("completed")
    elsif current_user.is_a?(Patient)
    end
  end
end
