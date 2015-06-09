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

ActiveRecord::Schema.define(version: 20150609132627) do

  create_table "admins", force: :cascade do |t|
    t.string   "email"
    t.string   "password_digest"
    t.string   "tax_id"
    t.boolean  "non_profit"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "authentications", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.string   "provider",   null: false
    t.string   "uid",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "authentications", ["provider", "uid"], name: "index_authentications_on_provider_and_uid"

  create_table "events", force: :cascade do |t|
    t.text     "name"
    t.integer  "user_id"
    t.text     "uncut_exp"
    t.integer  "language_id"
    t.integer  "source_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "languages", force: :cascade do |t|
    t.text     "name"
    t.text     "color"
    t.text     "badge"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ongoing_quests", force: :cascade do |t|
    t.integer  "quest_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "quests", force: :cascade do |t|
    t.string   "name"
    t.integer  "bounty"
    t.string   "link"
    t.integer  "quantity"
    t.integer  "language_id"
    t.integer  "source_id"
    t.integer  "admin_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "skills", force: :cascade do |t|
    t.text     "user_id"
    t.text     "language_id"
    t.text     "experience"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "sources", force: :cascade do |t|
    t.text     "name"
    t.decimal  "exp_multiplier"
    t.text     "logo"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "github_key"
    t.string   "rescue_key"
    t.integer  "logins"
    t.datetime "last_rescued"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

end
