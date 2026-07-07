class AddReferenceToAppointments < ActiveRecord::Migration[8.1]
  def change
    add_column :appointments, :refer_to, :integer
  end
end
