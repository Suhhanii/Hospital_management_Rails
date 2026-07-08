# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_07_08_135105) do
  create_table "appointments", force: :cascade do |t|
    t.datetime "appointment_at", null: false
    t.datetime "created_at", null: false
    t.integer "doctor_id", null: false
    t.integer "duration", default: 30
    t.integer "patient_id", null: false
    t.integer "refer_to"
    t.string "status", default: "scheduled"
    t.datetime "updated_at", null: false
    t.index ["doctor_id", "appointment_at"], name: "index_appointments_on_doctor_id_and_appointment_at", unique: true
    t.index ["doctor_id"], name: "index_appointments_on_doctor_id"
    t.index ["patient_id", "appointment_at"], name: "index_appointments_on_patient_id_and_appointment_at", unique: true
    t.index ["patient_id"], name: "index_appointments_on_patient_id"
  end

  create_table "doctors", force: :cascade do |t|
    t.string "contact_number"
    t.datetime "created_at", null: false
    t.string "email"
    t.string "name", null: false
    t.integer "specialization_id", null: false
    t.boolean "status", default: true
    t.datetime "updated_at", null: false
    t.index ["contact_number"], name: "uniq_phone", unique: true
    t.index ["email"], name: "uniq_email", unique: true
    t.index ["specialization_id"], name: "index_doctors_on_specialization_id"
    t.check_constraint "email LIKE '%@gmail.com' OR email LIKE '%@shriffle.com'", name: "email_check"
  end

  create_table "patients", force: :cascade do |t|
    t.string "contact_number"
    t.datetime "created_at", null: false
    t.date "dob", null: false
    t.string "email"
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.index ["contact_number"], name: "index_patients_on_contact_number"
    t.index ["email"], name: "index_patients_on_email"
  end

  create_table "specializations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
    t.index ["name"], name: "uniq_name", unique: true
  end

  create_table "working_hours", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "day_of_week"
    t.integer "doctor_id", null: false
    t.time "end_time"
    t.time "start_time"
    t.datetime "updated_at", null: false
    t.index ["doctor_id"], name: "index_working_hours_on_doctor_id"
    t.check_constraint "day_of_week BETWEEN 0 AND 6", name: "day_of_week_check"
    t.check_constraint "end_time > start_time", name: "working_hour_check"
  end

  add_foreign_key "appointments", "doctors"
  add_foreign_key "appointments", "patients"
  add_foreign_key "doctors", "specializations"
  add_foreign_key "working_hours", "doctors"
end
