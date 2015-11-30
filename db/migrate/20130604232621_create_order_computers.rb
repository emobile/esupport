class CreateOrderComputers < ActiveRecord::Migration
  def change
    create_table :order_computers do |t|
      t.references :order
      t.references :computer

      t.timestamps
    end
    add_index :order_computers, :order_id
    add_index :order_computers, :computer_id
  end
end
