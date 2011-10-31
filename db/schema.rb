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

ActiveRecord::Schema.define(:version => 20111031054019) do

  create_table "assignments", :force => true do |t|
    t.integer  "chore_id",                       :null => false
    t.integer  "user_id",                        :null => false
    t.date     "date",                           :null => false
    t.boolean  "is_complete", :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "assignments", ["chore_id"], :name => "assignments_chore_id_fk"
  add_index "assignments", ["user_id"], :name => "assignments_user_id_fk"

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "authentications", ["user_id"], :name => "authentications_user_id_fk"

  create_table "chores", :force => true do |t|
    t.integer  "group_id"
    t.string   "name",                                :default => "", :null => false
    t.integer  "difficulty",                                          :null => false
    t.text     "schedule_yaml", :limit => 2147483647
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "chores", ["group_id"], :name => "chores_group_id_fk"

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invitations", :force => true do |t|
    t.string   "email"
    t.integer  "group_id"
    t.string   "role"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "invitations", ["email"], :name => "index_invitations_on_email"
  add_index "invitations", ["group_id", "email"], :name => "index_invitations_on_group_id_and_email"
  add_index "invitations", ["group_id"], :name => "index_invitations_on_group_id"

  create_table "memberships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.boolean  "is_admin",   :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "memberships", ["group_id"], :name => "memberships_group_id_fk"
  add_index "memberships", ["user_id"], :name => "memberships_user_id_fk"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "name"
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

  add_foreign_key "assignments", "chores", :name => "assignments_chore_id_fk", :dependent => :delete
  add_foreign_key "assignments", "users", :name => "assignments_user_id_fk", :dependent => :delete

  add_foreign_key "authentications", "users", :name => "authentications_user_id_fk", :dependent => :delete

  add_foreign_key "chores", "groups", :name => "chores_group_id_fk", :dependent => :delete

  add_foreign_key "invitations", "groups", :name => "invitations_group_id_fk", :dependent => :delete

  add_foreign_key "memberships", "groups", :name => "memberships_group_id_fk", :dependent => :delete
  add_foreign_key "memberships", "users", :name => "memberships_user_id_fk", :dependent => :delete

end
