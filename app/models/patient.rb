class Patient < ApplicationRecord
  has_many :appointments, dependent: :destroy
  has_many :patients, through: :appointments

  validates :name, presence: true
  validates :email, format: URI::MailTo::EMAIL_REGEXP
  validate :is_dob_valid
  validate :is_contact_valid

  private
  def is_contact_valid
    errors.add(:phone, "contact number should be 10 digits, not contain string or any special character") unless phone.to_s.match?(/\A\d{10}\z/)
  end

  def is_dob_valid
    errors.add(:dob, "date of birth should be in past") unless dob < Time.now
  end
end
