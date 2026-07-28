class DoctorsController < ApplicationController
  def index
    @doctors = Doctor.active
    respond_to do |format|
      format.html
      format.json { render json: @doctors }
    end
  end
end
