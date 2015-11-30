class CreateComputers < ActiveRecord::Migration
  def change
    create_table :computers do |t|
      t.string :brand
      t.string :model
      t.string :ope_system
      t.string :serial_number
      t.string :computer_type
      t.string :hard_drive
      t.string :units
      t.string :memory
      t.string :proccessor
      t.string :color
      t.string :charger
      t.string :usb
      t.string :monitor
      t.string :keyboard
      t.string :mouse
      t.references :client
      t.references :branch
      
      t.timestamps
    end
    add_index :computers, :client_id
    add_index :computers, :branch_id
  end
end
