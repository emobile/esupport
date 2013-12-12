class CreateErrorReports < ActiveRecord::Migration
  def change
    create_table :error_reports do |t|
      t.string :user
      t.string :controller_name
      t.string :action_name
      t.string :line_number
      t.string :referrer_url
      t.string :original_path
      t.string :environment
      t.references :branch
      t.text :description
      t.text :backtrace
      t.date :error_time

      t.timestamps
    end
    add_index :error_reports, :branch_id
  end
end
