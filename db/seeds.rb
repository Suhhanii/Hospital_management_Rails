
# 1. create User model
# 2. make relation has_many doctor_appointments
# 3. make relation has_many patient_appointments
# 4. in appointment model belongs to doctor(id) class name user
# 5. in appointment model belongs to patient(id) class name user


# 6














# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


# select doctor.* from doctor left join appointments on doctor.id =appointments.doctor.id



# Doctor.includes(:appointments).group('doctor.id').order('COUNT(appointments.id) DESC').references(:appointments)

# SELECT "doctors"."id" AS t0_r0, "doctors"."name" AS t0_r1, "doctors"."email" AS t0_r2, "doctors"."contact_number" AS t0_r3, "doctors"."status" AS t0_r4, "doctors"."specialization_id" AS t0_r5, "doctors"."created_at" AS t0_r6, "doctors"."updated_at" AS t0_r7, "appointments"."id" AS t1_r0, "appointments"."doctor_id" AS t1_r1, "appointments"."patient_id" AS t1_r2, "appointments"."appointment_at" AS t1_r3, "appointments"."duration" AS t1_r4, "appointments"."status" AS t1_r5, "appointments"."created_at" AS t1_r6, "appointments"."updated_at" AS t1_r7, "appointments"."refer_to" AS t1_r8


# FROM "doctors" LEFT OUTER JOIN "appointments" ON "appointments"."doctor_id" = "doctors"."id"

# GROUP BY "appointments"."doctor_id" /* loading for pp */ ORDER BY COUNT(appointments.id) DESC LIMIT 11 /*application='Hospital'*/



# SELECT "doctors".* FROM "doctors"

#  GROUP BY "appointments"."doctor_id" /* loading for pp */ ORDER BY COUNT(appointments.id) DESC LIMIT 11 /*application='Hospital'*/

# Doctor.create!(name: "kretos",email: "kretos@gmail.com",contact_number: "5987690909",specialization_id: 1)

# Patient.create!(name: "candy",email: "candy@gmail.com",contact_number: "6565423231",dob: Date.new(2001,2,3))

# Appointment.new(patient_id: 1,doctor_id: 1,appointment_at: "2026-08-09 8:00 pm")


# Specialization.create!(name: "Cardiologists")

# Doctor.create!(name: "doctor", password: "Doctor@123", email: "doctor@gmail.com", specialization: Specialization.first, contact_number: "1234567890")

# WorkingHour.create!(day_of_week: 1, start_time: Time.zone.strptime("12:00 am","%I:%M %p"),end_time: Time.zone.strptime("6:00 pm","%I:%M %p"),doctor_id: 1)

# Patient.create!(name: "patient", password: "Patient@123", email: "patient@gmail.com",  contact_number: "1234567890",dob: Date.new(2000,9,1))

# p=Patient.first
# p.book_appointment(1,"2026-07-20 1:00 pm")

# u.appointments.where("appointment_at > ?",Date.tomorrow)
# u.appointments.where(appointment_at: Date.today.all_day)

# u.appointments.where("appointment_at < ?",Date.today)