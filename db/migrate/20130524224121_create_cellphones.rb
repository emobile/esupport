class CreateCellphones < ActiveRecord::Migration
  def change
    create_table :cellphones do |t|
      t.string :model
      t.string :brand
      t.string :color
      t.string :ope_system
      t.string :imei
      t.references :client
      t.references :branch
      
      t.timestamps
    end
    add_index :cellphones, :client_id
    add_index :cellphones, :branch_id
  end
end
