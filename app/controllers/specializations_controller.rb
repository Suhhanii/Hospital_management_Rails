class SpecializationsController < ApplicationController
  def index
    @specialization = current_user.specialization.name if current_user.specialization.present?
    respond_to do |format|
      format.html 
      format.json { render json: @specialization }
    end 
  end
end
