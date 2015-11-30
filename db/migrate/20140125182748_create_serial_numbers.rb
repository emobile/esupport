class CreateSerialNumbers < ActiveRecord::Migration
  def change
    create_table :serial_numbers do |t|
      t.references :part
      t.string :serial_number

      t.timestamps
    end
    add_index :serial_numbers, :part_id
  end
end