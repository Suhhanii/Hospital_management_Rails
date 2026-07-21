class User < ApplicationRecord
  # self.inheritance_column = "type"
  has_secure_password
  STRICT_EMAIL_REGEXP = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]{2,6}\z/i

  validates :name, presence: true
  # validates :password, presence: true, on: :create
  validates :email, presence: true, uniqueness: true, format: {with: STRICT_EMAIL_REGEXP}

  has_many :doctor_appointments, class_name: "Appointment", foreign_key: :doctor_id, dependent: :destroy

  # has_many :working_hours, class_name: "WorkingHour", dependent: :destroy

  has_many :doctors, through: :doctor_appointments

  has_many :patient_appointments, class_name: "Appointment", foreign_key: :patient_id, dependent: :destroy

  has_many :patients, through: :patient_appointments

end
