class Doctor < User
  has_secure_password
  belongs_to :specialization
  has_many :appointments, dependent: :destroy
  # has_many :pappointments, dependent: :destroy
  # has_many :patients, through: :appointments
  has_many :working_hours, class_name: "WorkingHour", dependent: :destroy

  # validates :name, :status, presence: true
  # validate :validate_email_and_contact

  scope :no_appointment, -> { where.missing(:appointments) }
  scope :active, -> { where(status: true) }

  scope :highest_number_of_appointment, -> { includes(:appointments).group("appointments.doctor_id").order("COUNT(appointments.id) DESC").references(:appointments).limit(1) }

  def active?
    status
  end

  # private

  # def validate_email_and_contact
  #   errors.add(:email, "email should contain domains are @shriffle.com, @gmail.com") unless email_valid?
  #   errors.add(:contact_number, "contact number should be 10 digits, not contain string or any special character") unless contact_valid?
  # end

  # def email_valid?
  #   email.present? && email.include?("@gmail.com") || email.include?("@shriffle.com")
  # end

  # def contact_valid?
  #    contact_number.to_s.match?(/\A\d{10}\z/)
  # end
end