# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_11_03_141314) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "jwt_denylists", force: :cascade do |t|
    t.string "jti"
    t.datetime "exp"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["jti"], name: "index_jwt_denylists_on_jti"
  end

  create_table "meals", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "ingredients"
    t.integer "servings_minimum"
    t.decimal "price_minimum"
    t.string "cover_image"
    t.text "description"
    t.index ["user_id"], name: "index_meals_on_user_id"
  end

  create_table "order_meals", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.bigint "meal_id"
    t.integer "total_servings"
    t.decimal "subtotal"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "unit_price"
    t.index ["meal_id"], name: "index_order_meals_on_meal_id"
    t.index ["order_id"], name: "index_order_meals_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "customer_id", null: false
    t.bigint "caterer_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "submitted", default: false
    t.date "submitted_on"
    t.boolean "abandoned", default: false
    t.date "abandoned_on"
    t.decimal "subtotal"
    t.boolean "accepted", default: false
    t.date "accepted_on"
    t.index ["caterer_id"], name: "index_orders_on_caterer_id"
    t.index ["customer_id"], name: "index_orders_on_customer_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "first_name"
    t.string "last_name"
    t.boolean "caterer_user"
    t.string "caterer_business_name"
    t.string "caterer_business_address"
    t.string "caterer_business_city"
    t.string "caterer_business_state"
    t.integer "zip_code"
    t.string "caterer_business_cover_image"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "meals", "users"
  add_foreign_key "order_meals", "meals"
  add_foreign_key "order_meals", "orders"
  add_foreign_key "orders", "users", column: "caterer_id"
  add_foreign_key "orders", "users", column: "customer_id"
end
