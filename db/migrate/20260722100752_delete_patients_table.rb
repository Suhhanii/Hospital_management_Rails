class DeletePatientsTable < ActiveRecord::Migration[8.1]
  def change
    drop_table :doctors
  end
end
