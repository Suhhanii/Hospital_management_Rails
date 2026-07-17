class UsersController < ApplicationController

  # def dashboard
  #   # byebug
  #   if session[:doctor_name]
  #     @doc = Doctor.find(session[:user_id])
  #     @a = @doc.appointments
  #     @today_schedule_app = @a.todays_appointments("scheduled")
  #     @today_cancel_app = @a.todays_appointments("canceled")
  #     @today_completed_app = @a.todays_appointments("completed")
  #   else session[:patient_name]

  #   end

  # end
  def show
    @user = User.find(params[:id])
  end
end
