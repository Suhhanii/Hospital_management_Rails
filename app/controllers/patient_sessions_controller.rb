class PatientSessionsController < ApplicationController

  def create
    # byebug
    patient = Patient.find_by(email: params[:email],password: params[:password])
    # byebug
    if patient
      session[:patient_id] = patient.id
      session[:patient_name] = patient.name
      redirect_to patients_path
    else
      flash[:alert] = "Wrong Email and Password Try Again"
      redirect_to patient_login_path
    end
  end
end


#(byebug) params
#<ActionController::Parameters {"authenticity_token" => "QkENRrU082-D341B_BlF-Oc0WdgzxpxLgng82AClBuDJkElZYbQ_6wTHV4qRDjFd8VBkBlCB3HKHCyoYo1il6Q", "email" => "suhanikaushal57@gmail.com", "password" => "sfg", "commit" => "Login", "controller" => "patient_sessions", "action" => "create"} permitted: false>
