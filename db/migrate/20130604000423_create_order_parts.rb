class CreateOrderParts < ActiveRecord::Migration
  def change
    create_table :order_parts do |t|
      t.references :order
      t.references :part

      t.timestamps
    end
    add_index :order_parts, :order_id
    add_index :order_parts, :part_id
  end
end
