class CreateBranchClients < ActiveRecord::Migration
  def change
    create_table :branch_clients do |t|
      t.references :branch
      t.references :client

      t.timestamps
    end
    add_index :branch_clients, :branch_id
    add_index :branch_clients, :client_id
  end
end
