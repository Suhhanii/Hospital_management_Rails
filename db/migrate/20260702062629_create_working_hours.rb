class CreateWorkingHours < ActiveRecord::Migration[8.1]
  def change
    create_table :working_hours do |t|
      t.integer :day_of_week
      t.time :start_time
      t.time :end_time
      t.integer :doctor_id, null: false#, foreign_key: true

      t.timestamps
    end

    # add_check_constraint :working_hours, "end_time > start_time", name: "working_hour_check"
    add_check_constraint :working_hours, "day_of_week BETWEEN 0 AND 6", name: "day_of_week_check"
  end
end
