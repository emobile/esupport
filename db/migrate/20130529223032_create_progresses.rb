class CreateProgresses < ActiveRecord::Migration
  def change
    create_table :progresses do |t|
      t.string :short_description
      t.text :full_description
      t.references :user
      t.references :order
      t.references :branch
      
      t.timestamps
    end
    add_index :progresses, :user_id
    add_index :progresses, :order_id
    add_index :progresses, :branch_id
  end
end
