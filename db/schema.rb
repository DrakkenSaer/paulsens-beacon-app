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

ActiveRecord::Schema.define(version: 20161216200104) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"
  enable_extension "uuid-ossp"

  create_table "beacons", force: :cascade do |t|
    t.uuid     "uuid",        default: -> { "uuid_generate_v4()" }, null: false
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "beacon_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["beacon_id"], name: "index_notifications_on_beacon_id", using: :btree
  end

  create_table "products", force: :cascade do |t|
    t.boolean  "featured",    default: false, null: false
    t.string   "cost"
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "promotions", force: :cascade do |t|
    t.string   "promotional_type"
    t.integer  "promotional_id"
    t.string   "title"
    t.text     "description"
    t.string   "code"
    t.integer  "redeem_count",     default: 0
    t.boolean  "daily_deal",       default: false
    t.boolean  "featured",         default: false
    t.integer  "cost"
    t.datetime "expiration"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.index ["promotional_type", "promotional_id"], name: "index_promotions_on_promotional_type_and_promotional_id", using: :btree
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.string   "resource_type"
    t.integer  "resource_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
    t.index ["name"], name: "index_roles_on_name", using: :btree
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
    t.hstore   "preferences"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["preferences"], name: "index_users_on_preferences", using: :gin
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree
  end

  add_foreign_key "notifications", "beacons"
end