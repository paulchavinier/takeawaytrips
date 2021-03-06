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

ActiveRecord::Schema.define(version: 20160930140854) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bloguers", force: :cascade do |t|
    t.string   "name"
    t.string   "author"
    t.text     "short_desc"
    t.text     "long_desc"
    t.string   "location"
    t.string   "facebook"
    t.string   "instagram"
    t.string   "twitter"
    t.string   "website"
    t.string   "profile_pic"
    t.string   "banner"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "user_id"
    t.text     "question1"
    t.text     "answer1"
    t.text     "question2"
    t.text     "answer2"
    t.text     "question3"
    t.text     "answer3"
    t.text     "question4"
    t.text     "answer4"
    t.text     "question5"
    t.text     "answer5"
    t.text     "introduction"
    t.text     "conclusion"
    t.string   "facebook_pic"
    t.string   "slug"
  end

  add_index "bloguers", ["user_id"], name: "index_bloguers_on_user_id", using: :btree

  create_table "cards", force: :cascade do |t|
    t.string   "banner_picture"
    t.string   "name"
    t.string   "category"
    t.string   "formatted_address"
    t.string   "international_phone_number"
    t.string   "website"
    t.string   "opening_hours",              default: [],              array: true
    t.integer  "price_level"
    t.text     "personnal_note"
    t.integer  "guide_id"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.float    "latitude"
    t.float    "longitude"
    t.string   "photo"
    t.string   "rating"
    t.string   "gphoto"
    t.boolean  "open_now"
  end

  add_index "cards", ["guide_id"], name: "index_cards_on_guide_id", using: :btree

  create_table "contacts", force: :cascade do |t|
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "guides", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "photo"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "place"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "place_type"
    t.string   "gphoto"
    t.string   "privacy"
    t.string   "slug"
    t.string   "country"
  end

  add_index "guides", ["user_id"], name: "index_guides_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "provider"
    t.string   "uid"
    t.string   "picture"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "token"
    t.datetime "token_expiry"
    t.string   "photo"
    t.boolean  "admin",                  default: false, null: false
    t.boolean  "bloger"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "bloguers", "users"
  add_foreign_key "cards", "guides"
  add_foreign_key "guides", "users"
end
