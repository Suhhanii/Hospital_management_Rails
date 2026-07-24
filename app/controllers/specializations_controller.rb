class SpecializationsController < ApplicationController
  def index
    @specialization = current_user.specialization.name if current_user.specialization.present?
  end
end
