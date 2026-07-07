class Patient < ApplicationRecord
  has_many :appointments, dependent: :destroy
  has_many :patients, through: :appointments

  validates_associated :patients
  validates :name, presence: true
  validates :email, format: URI::MailTo::EMAIL_REGEXP
  validate :is_dob_valid
  validate :is_contact_valid

  def book_appointment(status: 'scheduled',refer_to: nil,doctor_id: nil)

    unless doctor_id
      doctor=Doctor.includes(:working_hours).active
      doctor.each do |doc|
        puts "Doctor id #{doc.id} Doctor name #{doc.name} specialization in #{doc.specialization.name}"
        puts "Doctor Timing"
        doc.working_hours.each do |t|
          puts
          puts t.day_of_week
          puts "start time = #{t.start_time}"
          puts "end time = #{t.end_time}"
        end
      end
      puts "enter doctor id"
      doctor_id = gets.chomp.to_i
    end

    appointments=Appointment.where("doctor_id = ? AND status = ?",doctor_id,"scheduled")

    puts "Doctors scheduled appointments"
    appointments.each do |obj|
        puts "------------------------"
        puts obj.appointment_at
        puts "------------------------"
    end

    puts "enter appointment date"
    date = gets.chomp.to_i

    puts "enter appointment month"
    month = gets.chomp.to_i

    puts "enter appointment year"
    year = gets.chomp.to_i

    puts "enter appointment time in formate HH:MM am/pm as per doctor working hours"
    time = gets.chomp

    appointment=self.appointments.new(doctor_id: doctor_id,appointment_at: "#{year}-#{month}-#{date} #{time}",status: status,refer_to: refer_to)

    if appointment.save
      puts "Appointment book successfully"
    else
      puts "Fail to Book Appointment"
      appointment.errors.full_messages.each do |message|
        puts message
      end
    end
  end

  def reschedule_my_appointment
    puts "Your Appointments"
    self.appointments.each do |obj|
      puts "appointment id #{obj.id} on #{obj.appointment_at} with doctor #{obj.doctor.name}"
    end

    puts "Enter appointment id for reschedule"
    reschedule_appointment_id = gets.chomp.to_i

    doc_id = self.appointments.find(reschedule_appointment_id).doctor_id

    Appointment.find(reschedule_appointment_id  ).update(status: "canceled")

    self.book_appointment(status: "rescheduled",refer_to: reschedule_appointment_id,doctor_id: doc_id)
  end

  private

  def is_contact_valid
    errors.add(:contact_number, "contact number should be 10 digits, not contain string or any special character") unless contact_number.to_s.match?(/\A\d{10}\z/)
  end

  def is_dob_valid
    errors.add(:dob, "date of birth should be in past") unless dob < Time.now
  end
end
