class DoctorSessionsController < ApplicationController

  def create
    # byebug
    patient = Doctor.find_by(email: params[:email],password: params[:password])
    # byebug
    if patient
      session[:doctor_id] = patient.id
      session[:doctor_name] = patient.name
      redirect_to doctors_path
    else
      flash[:alert] = "Wrong Email and Password Try Again"
      redirect_to doctor_login_path
    end
  end
end
end
