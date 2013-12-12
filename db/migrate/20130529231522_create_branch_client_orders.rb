class CreateBranchClientOrders < ActiveRecord::Migration
  def change
    create_table :branch_client_orders do |t|
      t.references :branch
      t.references :client
      t.references :order

      t.timestamps
    end
    add_index :branch_client_orders, :branch_id
    add_index :branch_client_orders, :client_id
    add_index :branch_client_orders, :order_id
  end
end
