class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :fullname
      t.string :email
      t.text :comment

      t.timestamps
    end
  end
end
