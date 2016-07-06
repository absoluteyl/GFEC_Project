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

ActiveRecord::Schema.define(version: 20160705144025) do

  create_table "api_keys", force: :cascade do |t|
    t.string   "api_key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "carts", force: :cascade do |t|
    t.string   "cart_status", default: "New Cart", null: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_id"
  end

  create_table "cities", force: :cascade do |t|
    t.string  "postcode"
    t.string  "name"
    t.integer "parent_id"
  end

  create_table "line_items", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "cart_id"
    t.integer  "merchandise_id"
    t.decimal  "unit_price",                 null: false
    t.integer  "quantity",       default: 1, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "seller_id"
  end

  add_index "line_items", ["cart_id"], name: "index_line_items_on_cart_id"
  add_index "line_items", ["merchandise_id"], name: "index_line_items_on_merchandise_id"
  add_index "line_items", ["order_id"], name: "index_line_items_on_order_id"

  create_table "locations", force: :cascade do |t|
    t.integer "city_id"
    t.string  "city"
    t.string  "address"
    t.string  "recipient"
    t.integer "user_id"
    t.string  "phone"
    t.decimal "lat",       precision: 15, scale: 12
    t.decimal "long",      precision: 15, scale: 12
  end

  create_table "merchandises", force: :cascade do |t|
    t.string   "title",                            null: false
    t.text     "description",                      null: false
    t.integer  "price",                default: 0, null: false
    t.integer  "amount",               default: 1, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "image_1_file_name"
    t.string   "image_1_content_type"
    t.integer  "image_1_file_size"
    t.datetime "image_1_updated_at"
    t.string   "image_2_file_name"
    t.string   "image_2_content_type"
    t.integer  "image_2_file_size"
    t.datetime "image_2_updated_at"
    t.string   "image_3_file_name"
    t.string   "image_3_content_type"
    t.integer  "image_3_file_size"
    t.datetime "image_3_updated_at"
    t.integer  "category_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "buyer_id"
    t.integer  "seller_id"
    t.string   "address"
    t.string   "order_status",   default: "In Progress"
    t.string   "payment_method"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.integer  "location_id"
  end

  create_table "subcategories", force: :cascade do |t|
    t.string  "name"
    t.integer "category_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                             default: "", null: false
    t.string   "encrypted_password",                default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                     default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.string   "username"
    t.string   "mobile"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "authentication_token",   limit: 30
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["username"], name: "index_users_on_username", unique: true

end
