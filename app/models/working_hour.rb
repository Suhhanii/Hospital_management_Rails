class WorkingHour < ApplicationRecord
  belongs_to :doctor

  enum :day_of_week, {sunday:0, monday:1, tuesday:2, wednesday: 3, thursday: 4,friday: 5, saturday: 6 }

  validates :start_time,presence: true
  validates :end_time, presence:true
  validates :day_of_week, presence: true
  validate :validating_duration

  private
  def validating_duration
    errors.add(:end_time, "end time should be greater then start time") unless start_time < end_time
  end
end
