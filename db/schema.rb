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

ActiveRecord::Schema.define(version: 20111202164224) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "vacancies", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "company"
    t.string   "url"
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.string   "owner_token"
    t.date     "expire_at"
    t.datetime "approved_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "admin_token"
    t.text     "excerpt_html"
    t.text     "description_html"
    t.string   "location"
  end

  add_index "vacancies", ["admin_token"], name: "index_vacancies_on_admin_token", using: :btree
  add_index "vacancies", ["approved_at"], name: "index_vacancies_on_approved_at", using: :btree
  add_index "vacancies", ["created_at"], name: "index_vacancies_on_created_at", using: :btree
  add_index "vacancies", ["expire_at"], name: "index_vacancies_on_expire_at", using: :btree
  add_index "vacancies", ["owner_token"], name: "index_vacancies_on_owner_token", using: :btree

end
