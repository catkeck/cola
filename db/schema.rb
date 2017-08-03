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

ActiveRecord::Schema.define(version: 20170803174549) do

  create_table "cash_registers", force: :cascade do |t|
    t.integer "store_id"
    t.integer "register_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cashier_cash_registers", force: :cascade do |t|
    t.integer "cashier_id"
    t.integer "cash_register_id"
    t.datetime "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "status"
  end

  create_table "stores", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.integer "admin_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image"
    t.float "latitude"
    t.float "longitude"
  end

  create_table "tokens", force: :cascade do |t|
    t.date "date"
    t.string "code"
    t.integer "store_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "username"
    t.string "password_digest"
    t.integer "reputation"
    t.string "status"
    t.string "access"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "store_id"
  end

  create_table "visits", force: :cascade do |t|
    t.integer "customer_id"
    t.integer "store_id"
    t.integer "position"
    t.datetime "start_time"
    t.datetime "checkout_time"
    t.datetime "end_time"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "cashier_id"
  end

end
