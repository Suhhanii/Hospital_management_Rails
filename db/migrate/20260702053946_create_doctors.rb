class CreateDoctors < ActiveRecord::Migration[8.1]
  def change
    create_table :doctors do |t|
      t.string :name, null: false
      t.string :email, index: { unique: true, name: "uniq_email" }
      t.string :phone, index: { unique: true, name: "uniq_phone" }
      t.string :status, default: "active"
      t.references :specialization, null: false, foreign_key: true
      t.string :password, null: false

      t.timestamps
    end
    add_check_constraint :doctors, "email LIKE '%@gmail.com' OR email LIKE '%@shriffle.com'", name: "email_check"
  end
end
