class CreateBranches < ActiveRecord::Migration
  def change
    create_table :branches do |t|
      t.string :name
      t.string :email1
      t.string :email2
      t.string :webpage
      t.string :phone1
      t.string :phone2
      t.string :address1
      t.string :address2
      t.integer :zip
      t.string :city
      t.string :state
      t.string :country
      t.text :description

      t.timestamps
    end
  end
end
