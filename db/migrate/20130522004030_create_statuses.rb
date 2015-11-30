class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.string :name
      t.text :description
      t.integer :hierarchy
      t.references :branch

      t.timestamps
    end
    add_index :statuses, :branch_id
  end
end
