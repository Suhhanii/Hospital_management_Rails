class ChangeStatusColumnDataTypeInDoctors < ActiveRecord::Migration[8.1]
  def up
    # Remove the existing string default
    change_column_default :doctors, :status, nil

    # Convert existing values
    change_column :doctors,
                  :status,
                  :boolean,
                  using: "status = 'active'"

    # Set the new boolean default
    change_column_default :doctors, :status, true
  end

  def down
    # Remove boolean default
    change_column_default :doctors, :status, nil

    # Convert back to strings
    change_column :doctors,
                  :status,
                  :string,
                  using: "CASE WHEN status THEN 'active' ELSE 'inactive' END"

    # Restore string default
    change_column_default :doctors, :status, "active"
  end
end
