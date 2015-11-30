# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140128195202) do

  create_table "bills", :force => true do |t|
    t.string   "name"
    t.string   "rfc"
    t.string   "email"
    t.string   "phone1"
    t.string   "phone2"
    t.string   "fax"
    t.string   "address1"
    t.string   "address2"
    t.integer  "zip"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.integer  "client_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "bills", ["client_id"], :name => "index_bills_on_client_id"

  create_table "branch_client_orders", :force => true do |t|
    t.integer  "branch_id"
    t.integer  "client_id"
    t.integer  "order_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "branch_client_orders", ["branch_id"], :name => "index_branch_client_orders_on_branch_id"
  add_index "branch_client_orders", ["client_id"], :name => "index_branch_client_orders_on_client_id"
  add_index "branch_client_orders", ["order_id"], :name => "index_branch_client_orders_on_order_id"

  create_table "branch_clients", :force => true do |t|
    t.integer  "branch_id"
    t.integer  "client_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "branch_clients", ["branch_id"], :name => "index_branch_clients_on_branch_id"
  add_index "branch_clients", ["client_id"], :name => "index_branch_clients_on_client_id"

  create_table "branches", :force => true do |t|
    t.string   "name"
    t.string   "email1"
    t.string   "email2"
    t.string   "webpage"
    t.string   "phone1"
    t.string   "phone2"
    t.string   "address1"
    t.string   "address2"
    t.integer  "zip"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "cellphones", :force => true do |t|
    t.string   "model"
    t.string   "brand"
    t.string   "color"
    t.string   "ope_system"
    t.string   "imei"
    t.integer  "client_id"
    t.integer  "branch_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "cellphones", ["branch_id"], :name => "index_cellphones_on_branch_id"
  add_index "cellphones", ["client_id"], :name => "index_cellphones_on_client_id"

  create_table "client_needs", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "cost"
    t.integer  "branch_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "client_needs", ["branch_id"], :name => "index_client_needs_on_branch_id"

  create_table "clients", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone1"
    t.string   "phone2"
    t.string   "fax"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.integer  "zip"
    t.string   "country"
    t.integer  "role_id"
    t.integer  "branch_id"
    t.boolean  "active"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "username",                               :null => false
    t.string   "email",                                  :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "authentication_token"
  end

  add_index "clients", ["authentication_token"], :name => "index_clients_on_authentication_token", :unique => true
  add_index "clients", ["branch_id"], :name => "index_clients_on_branch_id"
  add_index "clients", ["confirmation_token"], :name => "index_clients_on_confirmation_token", :unique => true
  add_index "clients", ["email"], :name => "index_clients_on_email", :unique => true
  add_index "clients", ["reset_password_token"], :name => "index_clients_on_reset_password_token", :unique => true
  add_index "clients", ["role_id"], :name => "index_clients_on_role_id"
  add_index "clients", ["unlock_token"], :name => "index_clients_on_unlock_token", :unique => true

  create_table "comments", :force => true do |t|
    t.string   "fullname"
    t.string   "email"
    t.text     "comment"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "computers", :force => true do |t|
    t.string   "brand"
    t.string   "model"
    t.string   "ope_system"
    t.string   "serial_number"
    t.string   "computer_type"
    t.string   "hard_drive"
    t.string   "units"
    t.string   "memory"
    t.string   "proccessor"
    t.string   "color"
    t.string   "charger"
    t.string   "usb"
    t.string   "monitor"
    t.string   "keyboard"
    t.string   "mouse"
    t.integer  "client_id"
    t.integer  "branch_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "computers", ["branch_id"], :name => "index_computers_on_branch_id"
  add_index "computers", ["client_id"], :name => "index_computers_on_client_id"

  create_table "error_reports", :force => true do |t|
    t.string   "user"
    t.string   "controller_name"
    t.string   "action_name"
    t.string   "line_number"
    t.string   "referrer_url"
    t.string   "original_path"
    t.string   "environment"
    t.integer  "branch_id"
    t.text     "description"
    t.text     "backtrace"
    t.date     "error_time"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "error_reports", ["branch_id"], :name => "index_error_reports_on_branch_id"

  create_table "order_cellphones", :force => true do |t|
    t.integer  "order_id"
    t.integer  "cellphone_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "order_cellphones", ["cellphone_id"], :name => "index_order_cellphones_on_cellphone_id"
  add_index "order_cellphones", ["order_id"], :name => "index_order_cellphones_on_order_id"

  create_table "order_client_needs", :force => true do |t|
    t.integer  "order_id"
    t.integer  "client_need_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "order_client_needs", ["client_need_id"], :name => "index_order_client_needs_on_client_need_id"
  add_index "order_client_needs", ["order_id"], :name => "index_order_client_needs_on_order_id"

  create_table "order_computers", :force => true do |t|
    t.integer  "order_id"
    t.integer  "computer_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "order_computers", ["computer_id"], :name => "index_order_computers_on_computer_id"
  add_index "order_computers", ["order_id"], :name => "index_order_computers_on_order_id"

  create_table "order_serial_numbers", :force => true do |t|
    t.integer  "order_id"
    t.integer  "serial_number_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "order_serial_numbers", ["order_id"], :name => "index_order_serial_numbers_on_order_id"
  add_index "order_serial_numbers", ["serial_number_id"], :name => "index_order_serial_numbers_on_serial_number_id"

  create_table "orders", :force => true do |t|
    t.integer  "client_id"
    t.string   "identifier"
    t.text     "condition"
    t.text     "failure"
    t.text     "comments"
    t.text     "accessories"
    t.integer  "workshop_id"
    t.boolean  "require_bill",  :default => false
    t.integer  "bill_id"
    t.integer  "status_id"
    t.integer  "branch_id"
    t.string   "product_type"
    t.float    "total_due",     :default => 0.0
    t.date     "delivery_date"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  add_index "orders", ["bill_id"], :name => "index_orders_on_bill_id"
  add_index "orders", ["branch_id"], :name => "index_orders_on_branch_id"
  add_index "orders", ["client_id"], :name => "index_orders_on_client_id"
  add_index "orders", ["status_id"], :name => "index_orders_on_status_id"
  add_index "orders", ["workshop_id"], :name => "index_orders_on_workshop_id"

  create_table "parts", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "serial_number"
    t.float    "cost"
    t.integer  "branch_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "parts", ["branch_id"], :name => "index_parts_on_branch_id"

  create_table "progresses", :force => true do |t|
    t.string   "short_description"
    t.text     "full_description"
    t.integer  "user_id"
    t.integer  "order_id"
    t.integer  "branch_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "progresses", ["branch_id"], :name => "index_progresses_on_branch_id"
  add_index "progresses", ["order_id"], :name => "index_progresses_on_order_id"
  add_index "progresses", ["user_id"], :name => "index_progresses_on_user_id"

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.boolean  "protected",    :default => false
    t.boolean  "super_admin",  :default => false
    t.boolean  "branch_admin", :default => false
    t.boolean  "orders_admin", :default => false
    t.boolean  "secretary",    :default => false
    t.boolean  "client",       :default => false
    t.text     "description"
    t.integer  "branch_id",    :default => 1
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "roles", ["branch_id"], :name => "index_roles_on_branch_id"

  create_table "serial_numbers", :force => true do |t|
    t.integer  "part_id"
    t.string   "serial_number"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "serial_numbers", ["part_id"], :name => "index_serial_numbers_on_part_id"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "statuses", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "hierarchy"
    t.integer  "branch_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "statuses", ["branch_id"], :name => "index_statuses_on_branch_id"

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone1"
    t.string   "phone2"
    t.string   "fax"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.integer  "zip"
    t.string   "country"
    t.integer  "role_id"
    t.integer  "branch_id"
    t.boolean  "active"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "username",                               :null => false
    t.string   "email",                                  :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "authentication_token"
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["branch_id"], :name => "index_users_on_branch_id"
  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["role_id"], :name => "index_users_on_role_id"
  add_index "users", ["unlock_token"], :name => "index_users_on_unlock_token", :unique => true

  create_table "workshops", :force => true do |t|
    t.string   "name"
    t.string   "email1"
    t.string   "email2"
    t.string   "phone1"
    t.string   "phone2"
    t.string   "fax"
    t.string   "address1"
    t.string   "address2"
    t.integer  "zip"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.text     "description"
    t.integer  "user_id"
    t.integer  "branch_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "workshops", ["branch_id"], :name => "index_workshops_on_branch_id"
  add_index "workshops", ["user_id"], :name => "index_workshops_on_user_id"

end
