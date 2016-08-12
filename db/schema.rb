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

ActiveRecord::Schema.define(version: 20160812100857) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "vacancies", force: :cascade do |t|
    t.string   "title",            limit: 255
    t.text     "description"
    t.string   "company",          limit: 255
    t.string   "url",              limit: 255
    t.string   "name",             limit: 255
    t.string   "email",            limit: 255
    t.string   "phone",            limit: 255
    t.string   "owner_token",      limit: 255
    t.date     "expire_at"
    t.datetime "approved_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "admin_token",      limit: 255
    t.text     "excerpt_html"
    t.text     "description_html"
    t.string   "location",         limit: 255
    t.decimal  "salary_min",                   default: "0.0"
    t.decimal  "salary_max",                   default: "0.0"
    t.string   "salary_currency",  limit: 3,   default: "RUB"
    t.string   "salary_unit",                  default: "month"
    t.string   "employment_type",              default: "full-time"
    t.boolean  "remote_position",              default: false
    t.index ["admin_token"], name: "index_vacancies_on_admin_token", using: :btree
    t.index ["approved_at"], name: "index_vacancies_on_approved_at", using: :btree
    t.index ["created_at"], name: "index_vacancies_on_created_at", using: :btree
    t.index ["expire_at"], name: "index_vacancies_on_expire_at", using: :btree
    t.index ["owner_token"], name: "index_vacancies_on_owner_token", using: :btree
  end

end
