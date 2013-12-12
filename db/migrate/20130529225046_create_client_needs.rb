class CreateClientNeeds < ActiveRecord::Migration
  def change
    create_table :client_needs do |t|
      t.string :name
      t.text :description
      t.integer :cost
      t.references :branch

      t.timestamps
    end
    add_index :client_needs, :branch_id
  end
end
