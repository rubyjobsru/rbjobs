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

ActiveRecord::Schema.define(version: 20180210150744) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "vacancies", force: :cascade do |t|
    t.string "title", limit: 255
    t.text "description"
    t.string "company", limit: 255
    t.string "url", limit: 255
    t.string "name", limit: 255
    t.string "email", limit: 255
    t.string "owner_token", limit: 255
    t.date "expire_at"
    t.datetime "approved_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "admin_token", limit: 255
    t.text "excerpt_html"
    t.text "description_html"
    t.string "location", limit: 255
    t.integer "salary_min"
    t.integer "salary_max"
    t.string "salary_currency", limit: 3
    t.string "salary_unit"
    t.string "employment_type", default: "full-time"
    t.boolean "remote_position", default: false
    t.index ["admin_token"], name: "index_vacancies_on_admin_token"
    t.index ["approved_at"], name: "index_vacancies_on_approved_at"
    t.index ["created_at"], name: "index_vacancies_on_created_at"
    t.index ["expire_at"], name: "index_vacancies_on_expire_at"
    t.index ["owner_token"], name: "index_vacancies_on_owner_token"
  end

end
