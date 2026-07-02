class RenamePhoneToContactNumberInPatient < ActiveRecord::Migration[8.1]
  def change
    rename_column :patients, :phone, :contact_number
  end
end
