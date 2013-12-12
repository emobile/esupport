class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone1
      t.string :phone2
      t.string :fax
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.integer :zip
      t.string :country
      t.references :role
      t.references :branch
      t.boolean :active
      
      t.timestamps
    end
    add_index :users, :role_id
    add_index :users, :branch_id
  end
end
