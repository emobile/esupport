class CreateBills < ActiveRecord::Migration
  def change
    create_table :bills do |t|
      t.string :name
      t.string :rfc
      t.string :email
      t.string :phone1
      t.string :phone2
      t.string :fax
      t.string :address1
      t.string :address2
      t.integer :zip
      t.string :city
      t.string :state
      t.string :country
      t.references :client

      t.timestamps
    end
    add_index :bills, :client_id
  end
end
