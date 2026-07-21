class Patient < User
  has_secure_password
  has_many :appointments, dependent: :destroy
  # has_many :doctors, through: :appointments

  # STRICT_EMAIL_REGEXP = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]{2,6}\z/i

  # validates :name, presence: true
  # validates :email, format: {with: STRICT_EMAIL_REGEXP}

  # validate if: :contact_number do
  #   errors.add(:contact_number, "should be 10 digits only") unless contact_number.to_s.match?(/\A\d{10}\z/)
  # end
  validates :dob, presence: true
  validate if: :dob do
     errors.add(:dob, "date of birth should be in past") unless dob.past?
  end

  scope :no_appointment, -> { where.missing(:appointments) }

  scope :visit_most, -> { Appointment.patient_visit_most.first.patient }

  def book_appointment(doctor_id, app_time, refer_to: nil)
    appointment = self.appointments.new(doctor_id: doctor_id, appointment_at: app_time, refer_to: refer_to)

    if appointment.save
      puts "Appointment book successfully"
    else
      puts "Fail to Book Appointment"
      appointment.errors.full_messages.each do |message|
        puts message
      end
    end
  end

  # def reschedule_my_appointment(appointment_at)
  #   byebug
  #   doc_id = self.appointments.find(reschedule_app_id).doctor_id

  #   Appointment.find(reschedule_app_id).update(status: "canceled")

  #   self.book_appointment(doc_id,appointment_at,refer_to: reschedule_app_id)
  # end
end
