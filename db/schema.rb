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

ActiveRecord::Schema.define(version: 20170409021108) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "alerts", force: :cascade do |t|
    t.integer  "trigger_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["trigger_id"], name: "index_alerts_on_trigger_id", using: :btree
  end

  create_table "triggers", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "modified_file"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.text     "message"
    t.string   "email"
    t.index ["user_id"], name: "index_triggers_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "github_events_secret"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "email"
    t.string   "password_digest"
  end

end
