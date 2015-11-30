class CreateOrderSerialNumbers < ActiveRecord::Migration
  def change
    create_table :order_serial_numbers do |t|
      t.references :order
      t.references :serial_number

      t.timestamps
    end
    add_index :order_serial_numbers, :order_id
    add_index :order_serial_numbers, :serial_number_id
  end
end