class CreateSpecializations < ActiveRecord::Migration[8.1]
  def change
    create_table :specializations do |t|
      t.string :name, index: {unique: true, name: "uniq_name"}

      t.timestamps
    end
  end
end
