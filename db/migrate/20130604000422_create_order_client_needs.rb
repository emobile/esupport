class CreateOrderClientNeeds < ActiveRecord::Migration
  def change
    create_table :order_client_needs do |t|
      t.references :order
      t.references :client_need

      t.timestamps
    end
    add_index :order_client_needs, :order_id
    add_index :order_client_needs, :client_need_id
  end
end
