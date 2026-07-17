class DashboardController < ApplicationController
    def user_show
      # byebug
      if session[:doctor_name]
        @doc = Doctor.find(session[:user_id])
        @a = @doc.appointments
        @today_schedule_app = @a.todays_appointments("scheduled")
        @today_cancel_app = @a.todays_appointments("canceled")
        @today_completed_app = @a.todays_appointments("completed")
        # byebug
        render "dashboard/user_show", formats: [:html]
      else session[:patient_name]
      end
    end
end
