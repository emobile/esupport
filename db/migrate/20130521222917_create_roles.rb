class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name
      t.boolean :protected, :default => false
      t.boolean :super_admin, :default => false
      t.boolean :branch_admin, :default => false
      t.boolean :orders_admin, :default => false
      t.boolean :secretary, :default => false
      t.boolean :client, :default => false
      t.text :description
      t.references :branch, :default => 1

      t.timestamps
    end
    add_index :roles, :branch_id
  end
end
