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

ActiveRecord::Schema.define(version: 20171126160909) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "customer_clusters", force: :cascade do |t|
    t.integer  "dishes_in_c1"
    t.integer  "dishes_in_c2"
    t.integer  "dishes_in_c3"
    t.integer  "dishes_in_c4"
    t.integer  "dishes_in_c5"
    t.integer  "dishes_in_c6"
    t.integer  "centroid"
    t.integer  "customer_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["customer_id"], name: "index_customer_clusters_on_customer_id", using: :btree
  end

  create_table "customers", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "address"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["first_name"], name: "index_customers_on_first_name", using: :btree
    t.index ["last_name"], name: "index_customers_on_last_name", using: :btree
  end

  create_table "dish_clusters", force: :cascade do |t|
    t.integer  "centroid"
    t.integer  "dish_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dish_id"], name: "index_dish_clusters_on_dish_id", using: :btree
  end

  create_table "dishes", force: :cascade do |t|
    t.string   "name"
    t.float    "price"
    t.float    "calories"
    t.integer  "restaurant_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["restaurant_id"], name: "index_dishes_on_restaurant_id", using: :btree
  end

  create_table "items", force: :cascade do |t|
    t.integer  "quantity"
    t.integer  "order_id"
    t.integer  "dish_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dish_id"], name: "index_items_on_dish_id", using: :btree
    t.index ["order_id"], name: "index_items_on_order_id", using: :btree
  end

  create_table "orders", force: :cascade do |t|
    t.datetime "deliver_late"
    t.string   "status"
    t.integer  "customer_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["customer_id"], name: "index_orders_on_customer_id", using: :btree
  end

  create_table "restaurants", force: :cascade do |t|
    t.string   "name"
    t.string   "contact_name"
    t.string   "contact_phone"
    t.string   "email"
    t.string   "address"
    t.datetime "open_at"
    t.datetime "close_at"
    t.integer  "days_of_the_week"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_foreign_key "customer_clusters", "customers"
  add_foreign_key "dish_clusters", "dishes"
  add_foreign_key "dishes", "restaurants"
  add_foreign_key "items", "dishes"
  add_foreign_key "items", "orders"
  add_foreign_key "orders", "customers"
end
