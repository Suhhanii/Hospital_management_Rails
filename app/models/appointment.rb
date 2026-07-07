class Appointment < ApplicationRecord

  belongs_to :doctor
  belongs_to :patient

  validates :status, presence:true

  enum :status, {scheduled: "scheduled",canceled: "canceled", completed: "completed"}

  validate :appointments_cannot_booked_in_past, if: :check_changes?
  validate :doctor_should_be_active
  validate :within_working_hour, if: :check_changes?
  validate :no_two_appointment_at_same_time, if: :check_changes?

  scope :overdues, -> { scheduled.where("appointment_at < ?", Time.now)}

  def reschedule?
    refer_to.present?
  end

  def overdue?
    appointment_at < Time.now
  end

  private

  def check_changes?
     new_record? || appointment_at_changed?
  end

  def appointments_cannot_booked_in_past
    errors.add(:appointment_at,"Appointments cannot be booked in the past.") unless appointment_at > Time.now
  end

  def doctor_should_be_active
    errors.add(:doctor_id,"doctor should be active")unless doctor.active?
  end

  def within_working_hour
    w_hours = doctor.working_hours.find_by(day_of_week: appointment_at.wday)

    unless w_hours.present?
      errors.add(:doctor_not_available, "at this time")
      return
    end

    app_hours = appointment_at.strftime("%H:%M")

    start_hours = w_hours.start_time.strftime("%H:%M")
    end_hours = w_hours.end_time.strftime("%H:%M")

    valide_time = if start_hours > end_hours
                    app_hours.between?(start_hours, "23:59") || app_hours.between?("00:00", end_hours)
                  else
                    app_hours.between?(start_hours, end_hours)
                  end

    errors.add(:doctor_not_available, "at this time") unless valide_time
  end

  def no_two_appointment_at_same_time
    abc = appointment_at-29.minute..appointment_at+29.minute

    errors.add(:doctor_id,"doctor already have an appointment at given time") if Appointment.where(doctor_id: doctor_id, appointment_at: abc).exists?

    errors.add(:patient_id,"patient already have an appointment at given time") if Appointment.where(patient_id: patient_id, appointment_at: abc).exists?
  end
end
