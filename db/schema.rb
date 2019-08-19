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

ActiveRecord::Schema.define(version: 2019_08_19_054201) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "permissions", force: :cascade do |t|
    t.bigint "survey_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["survey_id"], name: "index_permissions_on_survey_id"
    t.index ["user_id"], name: "index_permissions_on_user_id"
  end

  create_table "submissions", force: :cascade do |t|
    t.bigint "survey_id"
    t.bigint "user_id"
    t.text "choices", array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["survey_id"], name: "index_submissions_on_survey_id"
    t.index ["user_id"], name: "index_submissions_on_user_id"
  end

  create_table "surveys", force: :cascade do |t|
    t.boolean "closed", default: false
    t.text "questions", array: true
    t.string "title", default: ''
    t.json "options"
    t.date "start_date"
    t.date "end_date"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_surveys_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "permissions", "surveys"
  add_foreign_key "permissions", "users"
  add_foreign_key "submissions", "surveys"
  add_foreign_key "submissions", "users"
  add_foreign_key "surveys", "users"
end
