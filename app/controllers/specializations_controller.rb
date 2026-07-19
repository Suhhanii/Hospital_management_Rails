class SpecializationsController < ApplicationController
  def index
    @specialization = current_user.specialization.name
  end

  def show
  end

  def delete
  end

  def edit
  end

  def new
  end
end
