class RenamePhoneToContactNumberInDoctor < ActiveRecord::Migration[8.1]
  def change
    rename_column :doctors, :phone, :contact_number
  end
end
