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

ActiveRecord::Schema.define(version: 2018_12_04_142940) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "games", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "min_players"
    t.integer "max_players"
    t.string "image_url", default: "https://images.unsplash.com/photo-1522069213448-443a614da9b6?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1352&q=80"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.time "time"
  end

  create_table "sessions", force: :cascade do |t|
    t.bigint "host_id"
    t.bigint "game_id"
    t.date "date"
    t.string "city"
    t.string "adress"
    t.text "description"
    t.integer "playernb"
    t.integer "maxplayers"
    t.integer "time"
    t.integer "status", default: 0
    t.integer "playerskill", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_sessions_on_game_id"
    t.index ["host_id"], name: "index_sessions_on_host_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "nickname"
    t.string "town"
    t.text "adress"
    t.integer "status", default: 1
    t.string "gender"
    t.integer "experience", default: 0
    t.text "description", default: ""
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
