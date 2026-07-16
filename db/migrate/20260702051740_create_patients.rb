class CreatePatients < ActiveRecord::Migration[8.1]
  def change
    create_table :patients do |t|
      t.string :name, null: false
      t.string :email, index: { unique: true, name: "uniq_email" }
      t.string :phone, index: { unique: true, name: "uniq_phone" }
      t.date :dob, null: false
      t.string :password, null: false

      t.timestamps
    end
  end
end
