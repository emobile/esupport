class CreateParts < ActiveRecord::Migration
  def change
    create_table :parts do |t|
      t.string :name
      t.text :description
      t.string :serial_number
      t.float :cost
      t.references :branch

      t.timestamps
    end
    add_index :parts, :branch_id
  end
end
