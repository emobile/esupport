class CreateWorkshops < ActiveRecord::Migration
  def change
    create_table :workshops do |t|
      t.string :name
      t.string :email1
      t.string :email2
      t.string :phone1
      t.string :phone2
      t.string :fax
      t.string :address1
      t.string :address2
      t.integer :zip
      t.string :city
      t.string :state
      t.string :country
      t.text :description
      t.references :user
      t.references :branch
      t.timestamps
    end
    add_index :workshops, :user_id
    add_index :workshops, :branch_id
  end
end
