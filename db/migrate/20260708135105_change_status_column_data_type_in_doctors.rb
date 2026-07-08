class ChangeStatusColumnDataTypeInDoctors < ActiveRecord::Migration[8.1]
  def up
    change_column :doctors, :status, :boolean, default: true
  end

  def down
    change_column :doctors, :status, :string, default: "active"
  end
end
