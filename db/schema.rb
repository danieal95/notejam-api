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

ActiveRecord::Schema.define(version: 20171211072318) do

  create_table "notes", force: :cascade do |t|
    t.integer "pad_id"
    t.integer "user_id"
    t.string "name"
    t.text "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pad_id"], name: "index_notes_on_pad_id"
    t.index ["user_id"], name: "index_notes_on_user_id"
  end

  create_table "pads", force: :cascade do |t|
    t.integer "user_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_pads_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
