class Patient < User
  has_many :appointments, dependent: :destroy

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
end
