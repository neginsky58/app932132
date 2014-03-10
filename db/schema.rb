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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140310052930) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "circles", force: true do |t|
    t.string   "zipcode"
    t.integer  "radius"
    t.integer  "location_x"
    t.integer  "location_y"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clothings", force: true do |t|
    t.string   "name"
    t.string   "desc"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "companies", force: true do |t|
    t.string   "facebook_id"
    t.string   "email"
    t.integer  "circle_id"
    t.integer  "company_status_id"
    t.string   "name"
    t.string   "desc"
    t.string   "url"
    t.string   "hours"
    t.string   "phone"
    t.integer  "rating"
    t.boolean  "is_active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "conditions", force: true do |t|
    t.string   "name"
    t.string   "desc"
    t.integer  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "creditcards", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "item_states", force: true do |t|
    t.string   "desc"
    t.string   "name"
    t.integer  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "items", force: true do |t|
    t.string   "name"
    t.string   "desc"
    t.integer  "item_state_id"
    t.decimal  "price",         precision: 10, scale: 2
    t.string   "currency"
    t.integer  "condition_id"
    t.boolean  "is_negotiable"
    t.integer  "category_id"
    t.string   "link"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "person_types", force: true do |t|
    t.string   "name"
    t.string   "desc"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photos", force: true do |t|
    t.integer  "item_id"
    t.string   "file"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "preferences", force: true do |t|
    t.integer  "item_id"
    t.integer  "clothing_id"
    t.integer  "size_id"
    t.integer  "person_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sizes", force: true do |t|
    t.string   "name"
    t.string   "desc"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_groups", force: true do |t|
    t.integer  "value"
    t.string   "name"
    t.string   "desc"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                                           default: "", null: false
    t.string   "encrypted_password",                              default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                                   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider"
    t.string   "facebook_id"
    t.string   "name"
    t.integer  "circle_id"
    t.integer  "preference_id"
    t.integer  "max_pickupradius"
    t.decimal  "max_price",              precision: 10, scale: 2
    t.decimal  "min_price",              precision: 10, scale: 2
    t.integer  "min_condition"
    t.string   "banned_reason"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.integer  "user_group_id",                                   default: 4
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
