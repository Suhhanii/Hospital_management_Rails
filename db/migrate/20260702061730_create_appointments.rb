class CreateAppointments < ActiveRecord::Migration[8.1]
  def change
    create_table :appointments do |t|
      t.references :doctor, null: false, foreign_key: true
      t.references :patient, null: false, foreign_key: true
      t.timestamp :appointment_at, null: false
      t.integer :duration, default:30
      t.string :status, default: "scheduled"

      t.timestamps
    end

    # add_index :appointments, [:doctor_id,:appointment_at, :patient_id], unique: true

    add_index :appointments, [:doctor_id,:appointment_at], unique: true
    add_index :appointments, [:patient_id,:appointment_at], unique: true

  end
end
