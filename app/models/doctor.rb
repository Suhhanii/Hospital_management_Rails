class Doctor < User
  belongs_to :specialization
  has_many :appointments, dependent: :destroy

  has_many :working_hours, class_name: "WorkingHour", dependent: :destroy

  scope :no_appointment, -> { where.missing(:appointments) }
  scope :active, -> { where(status: true) }

  scope :highest_number_of_appointment, -> { includes(:appointments).group("appointments.doctor_id").order("COUNT(appointments.id) DESC").references(:appointments).limit(1) }

  after_initialize :set_status

  def active?
    status
  end

  private

  def set_status
    self.status = true
  end
end
