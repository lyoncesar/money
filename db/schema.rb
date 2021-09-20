# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_09_20_050104) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "expenses", force: :cascade do |t|
    t.string "title", default: ""
    t.string "description", default: ""
    t.date "date"
    t.float "amount", default: 0.0
    t.integer "expense_type", default: 0
    t.string "duration", default: ""
    t.bigint "financial_control_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["financial_control_id"], name: "index_expenses_on_financial_control_id"
  end

  create_table "financial_controls", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_financial_controls_on_user_id"
  end

  create_table "financial_movements", force: :cascade do |t|
    t.string "name", default: ""
    t.string "description", default: ""
    t.float "amount", default: 0.0
    t.date "date"
    t.integer "movement_type", null: false
    t.string "duration", default: "", null: false
    t.bigint "financial_control_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["financial_control_id"], name: "index_financial_movements_on_financial_control_id"
  end

  create_table "movement_recurrencies", force: :cascade do |t|
    t.date "date"
    t.bigint "financial_movement_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["financial_movement_id"], name: "index_movement_recurrencies_on_financial_movement_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "expenses", "financial_controls"
  add_foreign_key "financial_controls", "users"
  add_foreign_key "financial_movements", "financial_controls"
  add_foreign_key "movement_recurrencies", "financial_movements"
end
