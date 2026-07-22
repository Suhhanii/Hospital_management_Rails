class User < ApplicationRecord
  has_secure_password
  STRICT_EMAIL_REGEXP = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]{2,6}\z/i

  validates :name, presence: true

  validates :email, presence: true, uniqueness: true, format: {with: STRICT_EMAIL_REGEXP}

  validates :contact_number, presence: true

  validate if: :contact_number do
    errors.add(:contact_number, "should be 10 digits only") unless contact_number.to_s.match?(/\A\d{10}\z/)
  end

  has_many :doctor_appointments, class_name: "Appointment", foreign_key: :doctor_id, dependent: :destroy

  has_many :doctors, through: :doctor_appointments

  has_many :patient_appointments, class_name: "Appointment", foreign_key: :patient_id, dependent: :destroy

  has_many :patients, through: :patient_appointments
end
