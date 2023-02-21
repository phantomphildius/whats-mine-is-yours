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

ActiveRecord::Schema[7.0].define(version: 2023_02_20_122451) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "budget_item_tags", force: :cascade do |t|
    t.bigint "budget_item_id", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["budget_item_id"], name: "index_budget_item_tags_on_budget_item_id"
  end

  create_table "budget_items", force: :cascade do |t|
    t.bigint "budget_id", null: false
    t.string "category", null: false
    t.integer "amount_cents", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["budget_id"], name: "index_budget_items_on_budget_id"
  end

  create_table "budget_memberships", force: :cascade do |t|
    t.bigint "budget_id", null: false
    t.bigint "user_id", null: false
    t.datetime "revoked_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["budget_id"], name: "index_budget_memberships_on_budget_id"
    t.index ["revoked_at"], name: "index_budget_memberships_on_revoked_at"
    t.index ["user_id"], name: "index_budget_memberships_on_user_id"
  end

  create_table "budgets", force: :cascade do |t|
    t.string "title", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "institutions", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "monthly_statements", force: :cascade do |t|
    t.date "time_period", null: false
    t.bigint "budget_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["budget_id"], name: "index_monthly_statements_on_budget_id"
    t.index ["time_period"], name: "index_monthly_statements_on_time_period"
  end

  create_table "statement_budget_items", force: :cascade do |t|
    t.bigint "budget_item_id", null: false
    t.bigint "statement_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["budget_item_id"], name: "index_statement_budget_items_on_budget_item_id"
    t.index ["statement_id"], name: "index_statement_budget_items_on_statement_id"
  end

  create_table "statement_transactions", force: :cascade do |t|
    t.bigint "statement_id", null: false
    t.date "date", null: false
    t.integer "amount_cents", null: false
    t.string "merchant", null: false
    t.string "category", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "statement_budget_item_id"
    t.index ["category"], name: "index_statement_transactions_on_category"
    t.index ["date"], name: "index_statement_transactions_on_date"
    t.index ["merchant"], name: "index_statement_transactions_on_merchant"
    t.index ["statement_budget_item_id"], name: "index_statement_transactions_on_statement_budget_item_id"
    t.index ["statement_id"], name: "index_statement_transactions_on_statement_id"
  end

  create_table "statements", force: :cascade do |t|
    t.date "time_period", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "institution_id"
    t.bigint "monthly_statement_id", null: false
    t.index ["institution_id"], name: "index_statements_on_institution_id"
    t.index ["monthly_statement_id"], name: "index_statements_on_monthly_statement_id"
    t.index ["time_period"], name: "index_statements_on_time_period"
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

  add_foreign_key "budget_item_tags", "budget_items"
  add_foreign_key "budget_items", "budgets"
  add_foreign_key "budget_memberships", "budgets"
  add_foreign_key "budget_memberships", "users"
  add_foreign_key "monthly_statements", "budgets"
  add_foreign_key "statement_budget_items", "budget_items"
  add_foreign_key "statement_budget_items", "statements"
  add_foreign_key "statement_transactions", "statement_budget_items"
  add_foreign_key "statement_transactions", "statements"
  add_foreign_key "statements", "monthly_statements"
end
