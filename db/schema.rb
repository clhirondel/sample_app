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

ActiveRecord::Schema.define(:version => 20111017134102) do

  create_table "attachments", :force => true do |t|
    t.string   "file"
    t.text     "description"
    t.integer  "attachable_id"
    t.string   "attachable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "campaigns", :force => true do |t|
    t.string   "name",               :limit => 32
    t.string   "campaign_type",      :limit => 32
    t.string   "description"
    t.string   "first_phone_number", :limit => 10
    t.string   "last_phone_number",  :limit => 10
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "clients", :force => true do |t|
    t.integer  "prospect_id"
    t.string   "string1"
    t.integer  "integer1"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "microposts", :force => true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "microposts", ["user_id"], :name => "index_microposts_on_user_id"

  create_table "prospects", :force => true do |t|
    t.string   "last_name",            :limit => 32
    t.string   "first_name",           :limit => 32
    t.string   "civility",             :limit => 3
    t.integer  "birthyear"
    t.string   "email",                :limit => 64
    t.string   "address"
    t.string   "postal_code",          :limit => 5
    t.string   "digital_code",         :limit => 10
    t.integer  "floor",                :limit => 3
    t.string   "city",                 :limit => 64
    t.string   "phone_number",         :limit => 10
    t.string   "office_phone_number",  :limit => 10
    t.string   "mobile_phone_number",  :limit => 10
    t.string   "situation_familiale",  :limit => 32
    t.integer  "nb_enfants",           :limit => 2
    t.integer  "nb_enfants_a_charges", :limit => 2
    t.string   "professional_status",  :limit => 32
    t.integer  "revenus_mensuels_net", :limit => 8
    t.string   "logement_rp",          :limit => 32
    t.integer  "mensualite_rp",        :limit => 8
    t.string   "impots_sur_le_revenu", :limit => 10
    t.integer  "charges_rp",           :limit => 8
    t.integer  "charges_autres",       :limit => 8
    t.integer  "taux_endettement",     :limit => 2
    t.string   "prospect_status",      :limit => 32
    t.datetime "rendezvous_at"
    t.string   "rendezvous_place",        :limit => 128
    t.string   "to_recall",            :limit => 10
    t.datetime "to_recall_at"
    t.string   "off_target_cause",     :limit => 32
    t.string   "comments"
    t.time     "timespent"
    t.integer  "campaign_id"
    t.integer  "user_id"
    t.integer  "consultant_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "prospects", ["campaign_id"], :name => "index_prospects_on_campaign_id"
  add_index "prospects", ["user_id"], :name => "index_prospects_on_user_id"

  create_table "relationships", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "relationships", ["followed_id"], :name => "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], :name => "index_relationships_on_follower_id_and_followed_id", :unique => true
  add_index "relationships", ["follower_id"], :name => "index_relationships_on_follower_id"

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "users", :force => true do |t|
    t.string   "lastname"
    t.string   "firstname"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.string   "encrypted_password"
    t.string   "salt"
    t.boolean  "admin",              :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
