class Appointment < ApplicationRecord
  belongs_to :doctor
  belongs_to :patient

  validates :status, presence:true
  validates :doctor_id, presence: true
  validates :patient_id, presence:true


  enum :status, {scheduled: "scheduled",canceled: "canceled", rescheduled: "rescheduled",completed: "completed"}

  # validate :appointments_cannot_booked_in_past
  validate :doctor_should_be_active
  validate :within_working_hour
  validate :no_two_appointment_at_same_time


  private

  def appointments_cannot_booked_in_past
    errors.add(:appointment_at,"Appointments cannot be booked in the past.") unless appointment_at > Time.now
  end

  def doctor_should_be_active
    # byebug
    errors.add(:doctor_id,"doctor should be active")unless doctor.active?
  end

  def within_working_hour
    errors.add(:working_hours, "appointment should be within time") unless appointment_at.strftime("%H:%M").between?(doctor.working_hours.find_by(day_of_week: appointment_at.wday).start_time.strftime("%H:%M"),doctor.working_hours.find_by(day_of_week: appointment_at.wday).end_time.strftime("%H:%M"))
  end

  def no_two_appointment_at_same_time
    # byebug
    errors.add(:doctor_id,"doctor already have an appointment at given time") if Appointment.where(doctor_id: doctor_id, appointment_at: appointment_at..30.minutes.after).exists?
    errors.add(:patient_id,"patient already have an appointment at given time") if Appointment.where(patient_id: patient_id, appointment_at: appointment_at..30.minutes.after).exists?


    # start_time = appointment_at.beginning_of_day
    # end_time = appointment_at.end_of_day
    # doctor_app = doctor.appointments.where()

  end
end
