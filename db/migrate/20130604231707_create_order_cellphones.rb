class CreateOrderCellphones < ActiveRecord::Migration
  def change
    create_table :order_cellphones do |t|
      t.references :order
      t.references :cellphone

      t.timestamps
    end
    add_index :order_cellphones, :order_id
    add_index :order_cellphones, :cellphone_id
  end
end
