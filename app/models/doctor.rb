
class Doctor < ApplicationRecord
  belongs_to :specialization
  has_many :appointments, dependent: :destroy
  has_many :patients, through: :appointments
  has_many :working_hours

  validates :name, presence: true
  validates :status, presence:true
  validate :is_doctor_object_valid

  enum :status, {active: "active",inactive: "inactive"}

  private
  def validate_email_and_contact
    errors.add(:email, "email should contain domains are @shriffle.com, @gmail.com") unless email_valid?
    errors.add(:contact_number, "contact number should be 10 digits, not contain string or any special character") unless contact_valid?
  end

  def email_valid?
    email.present? && email.include?("@gmail.com") || email.include?("@shriffle.com")
  end

  def contact_valid?
     contact_number.to_s.match?(/\A\d{10}\z/)
  end
end
