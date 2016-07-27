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

ActiveRecord::Schema.define(version: 20160608132027) do

  create_table "course_kinds", force: :cascade do |t|
    t.string   "name"
    t.decimal  "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "maxusers"
  end

  create_table "courses", force: :cascade do |t|
    t.date     "startdate"
    t.date     "enddate"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "course_kind_id"
  end

  add_index "courses", ["course_kind_id"], name: "index_courses_on_course_kind_id"

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], name: "index_roles_on_name"

  create_table "ships", force: :cascade do |t|
    t.string   "classtype"
    t.string   "name"
    t.boolean  "damage"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "course_kind_id"
  end

  add_index "ships", ["course_kind_id"], name: "index_ships_on_course_kind_id"

  create_table "user_courses", force: :cascade do |t|
    t.integer "course_id", null: false
    t.integer "user_id",   null: false
  end

  add_index "user_courses", ["user_id", "course_id"], name: "index_user_courses_on_user_id_and_course_id", unique: true

  create_table "users", force: :cascade do |t|
    t.string   "email",            null: false
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "firstname"
    t.string   "surenamePrefix"
    t.string   "surename"
    t.date     "birthdate"
    t.string   "city"
    t.integer  "telephone"
    t.string   "address"
    t.string   "zipcode"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"

end
