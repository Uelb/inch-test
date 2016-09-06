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

ActiveRecord::Schema.define(version: 20160906093120) do

  create_table "buildings", force: :cascade do |t|
    t.string   "reference"
    t.string   "address"
    t.string   "zip_code"
    t.string   "city"
    t.string   "country"
    t.string   "manager_name"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "past_attributes", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "value",      null: false
    t.string   "key",        null: false
    t.string   "tuple_type", null: false
    t.integer  "tuple_id",   null: false
  end

  add_index "past_attributes", ["value", "key", "tuple_type", "tuple_id"], name: "past_attributes_main_index", unique: true

  create_table "people", force: :cascade do |t|
    t.string   "reference"
    t.string   "email"
    t.string   "home_phone_number"
    t.string   "mobile_phone_number"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "address"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

end
