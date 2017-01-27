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

ActiveRecord::Schema.define(version: 20161216224648) do

  create_table "beacons", force: :cascade do |t|
    t.string   "uuid",        null: false
    t.string   "title",       null: false
    t.text     "description", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["uuid"], name: "index_beacons_on_uuid"
  end

  create_table "historical_events", force: :cascade do |t|
    t.string   "title",       null: false
    t.text     "description", null: false
    t.date     "date",        null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "line_items", force: :cascade do |t|
    t.integer  "order_id",       null: false
    t.string   "orderable_type", null: false
    t.integer  "orderable_id",   null: false
    t.string   "item_cost",      null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["order_id"], name: "index_line_items_on_order_id"
    t.index ["orderable_type", "orderable_id"], name: "index_line_items_on_orderable_type_and_orderable_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.string   "title",       null: false
    t.text     "description", null: false
    t.integer  "beacon_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["beacon_id"], name: "index_notifications_on_beacon_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "products", force: :cascade do |t|
    t.boolean  "featured",    default: false, null: false
    t.string   "cost",        default: "0",   null: false
    t.string   "title",                       null: false
    t.text     "description",                 null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "promotions", force: :cascade do |t|
    t.string   "promotional_type"
    t.integer  "promotional_id"
    t.string   "title",                                            null: false
    t.text     "description",                                      null: false
    t.string   "code",                                             null: false
    t.integer  "redeem_count",     default: 0,                     null: false
    t.boolean  "daily_deal",       default: false,                 null: false
    t.boolean  "featured",         default: false,                 null: false
    t.integer  "cost",             default: 0,                     null: false
    t.datetime "expiration",       default: '2017-02-09 23:57:35'
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.index ["promotional_type", "promotional_id"], name: "index_promotions_on_promotional_type_and_promotional_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.string   "resource_type"
    t.integer  "resource_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["name"], name: "index_roles_on_name"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "phone"
    t.integer  "points",                 default: 0
    t.string   "address"
    t.integer  "visit_count",            default: 0
    t.text     "preferences"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["preferences"], name: "index_users_on_preferences"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
  end

end
