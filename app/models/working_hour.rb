class WorkingHour < ApplicationRecord
  belongs_to :doctor

  enum :day_of_week, {monday:0, tuesday:1, wednesday: 2,thursday: 3,friday: 4, saturday: 5, sunday:6}

  validates :start_time,presence: true
  validates :end_time, presence:true
  validates :day_of_week, presence: true
  validate :validating_duration

  private
  def validating_duration
    errors.add(:end_time, "end time should be greater then start time") unless start_time <= end_time
  end
end
