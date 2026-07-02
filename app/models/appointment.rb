class Appointment < ApplicationRecord
  belongs_to :doctor
  belongs_to :patient

  validates :status, presence:true

  enum :status, {}
end
