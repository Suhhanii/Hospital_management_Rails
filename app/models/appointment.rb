class Appointment < ApplicationRecord
  belongs_to :doctor, class_name: "User", foreign_key: "doctor_id"
  belongs_to :patient, class_name: "User", foreign_key: "patient_id"

  validates :status, presence: true

  enum :status, { scheduled: "scheduled", canceled: "canceled", completed: "completed" }

  validate :appointments_cannot_booked_in_past,
           :within_working_hour,
           :no_two_appointment_at_same_time,
           if: -> { new_record? || appointment_at_changed? }

  validate if: :doctor do
    errors.add(:doctor_id, "doctor should be active") unless doctor.active?
  end

  scope :todays_appointments, ->(status) { where(appointment_at: Date.today.all_day, status: status) }

  # scope :upcoming_scheduled_appointments, -> { scheduled.where("appointment_at > ?", Date.today) }

  scope :patient_visit_most, -> { includes(:patient).completed.group("patient_id").order("COUNT(appointments.id) DESC").references(:appointments) }

  scope :overdues, -> { scheduled.where("appointment_at < ?", Time.now) }

  scope :today, ->{
    where(appointment_at: Date.today.all_day)
  }

  scope :upcoming, ->{
    where("appointment_at > ?",Date.tomorrow)
  }

  scope :past, ->{
    where("appointment_at < ?",Date.today)
  }

  def reschedule?
    refer_to.present?
  end

  def overdue?
    appointment_at.past?
  end

  def reschedule_appointment(new_date)
    errors.add(:error, "already canceled!") unless canceled? and return

    new_app = doctor.appointments.create(patient: patient, appointment_at: new_date, refer_to: id)

    if new_app.persisted?
      canceled!
    else
      errors.add(:error, new_app.errors.full_messages.join(","))
    end
  end

  private

  def appointments_cannot_booked_in_past
    errors.add(:appointment_at, "Appointments cannot be booked in the past.") if appointment_at.past?
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
    time_range = appointment_at-29.minute..appointment_at+29.minute

    errors.add(:doctor_id, "doctor already have an appointment at given time") if Appointment.where(doctor_id: doctor_id, appointment_at: time_range).exists?

    errors.add(:patient_id, "patient already have an appointment at given time") if Appointment.where(patient_id: patient_id, appointment_at: time_range).exists?
  end
end
