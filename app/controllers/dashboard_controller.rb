class DashboardController < ApplicationController
  def user_show
      @appointments = current_user.appointments
      @today_schedule_app = @appointments.todays_appointments("scheduled")
      @today_cancel_app   = @appointments.todays_appointments("canceled")
      @today_completed_app = @appointments.todays_appointments("completed")

      respond_to do |format|
        format.html
        format.json { render json: @appointments }
      end
  end
end
