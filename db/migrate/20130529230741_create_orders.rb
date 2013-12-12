class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :client
      t.string :identifier
      t.text :condition
      t.text :failure
      t.text :comments
      t.text :accessories
      t.references :workshop
      t.boolean :require_bill,    :default => false
      t.references :bill
      t.references :status
      t.references :branch
      t.string :product_type
      t.float :total_due,    :default => "0.0"
      t.date :delivery_date
      t.timestamps
      
    end
    add_index :orders, :client_id
    add_index :orders, :workshop_id
    add_index :orders, :bill_id
    add_index :orders, :status_id
    add_index :orders, :branch_id
  end
end
