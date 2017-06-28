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

ActiveRecord::Schema.define(version: 20170628035636) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "alerts", id: :serial, force: :cascade do |t|
    t.integer "trigger_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
    t.string "slack_webhook_url"
    t.text "message"
    t.index ["trigger_id"], name: "index_alerts_on_trigger_id"
  end

  create_table "email_addresses", force: :cascade do |t|
    t.string "address"
    t.string "address_type"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["address"], name: "index_email_addresses_on_address", unique: true
    t.index ["confirmation_token"], name: "index_email_addresses_on_confirmation_token", unique: true
    t.index ["user_id"], name: "index_email_addresses_on_user_id"
  end

  create_table "triggers", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "modified_file"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "message"
    t.string "email"
    t.string "branch"
    t.string "repository_name"
    t.string "slack_webhook_url"
    t.integer "email_address_id"
    t.index ["email_address_id"], name: "index_triggers_on_email_address_id"
    t.index ["user_id"], name: "index_triggers_on_user_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "github_events_secret"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.string "password_digest"
    t.index ["github_events_secret"], name: "index_users_on_github_events_secret", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

end
