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

ActiveRecord::Schema[7.1].define(version: 2025_03_17_125917) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shopline_customers", force: :cascade do |t|
    t.string "shopline_id"
    t.string "full_name"
    t.string "email"
    t.datetime "joined_at"
    t.string "join_source"
    t.string "language"
    t.integer "order_count"
    t.decimal "total_amount", precision: 10, scale: 2
    t.decimal "issued_shopping_credits", precision: 10, scale: 2
    t.decimal "deducted_shopping_credits", precision: 10, scale: 2
    t.decimal "used_shopping_credits", precision: 10, scale: 2
    t.decimal "current_shopping_credits", precision: 10, scale: 2
    t.integer "issued_points"
    t.integer "deducted_points"
    t.integer "used_points"
    t.integer "current_points"
    t.boolean "is_member"
    t.datetime "member_registered_at"
    t.string "member_registration_source"
    t.string "facebook_id"
    t.string "line_id"
    t.boolean "blacklisted"
    t.boolean "has_password"
    t.boolean "accept_email_marketing"
    t.boolean "accept_sms_marketing"
    t.boolean "accept_fb_marketing"
    t.boolean "accept_line_marketing"
    t.boolean "accept_whatsapp_marketing"
    t.datetime "last_login_at"
    t.string "phone"
    t.string "country_code"
    t.string "mobile_phone"
    t.string "recipient_name"
    t.string "recipient_phone"
    t.string "address_1"
    t.string "address_2"
    t.string "city"
    t.string "state"
    t.string "postal_code"
    t.string "country"
    t.string "membership_level"
    t.date "membership_expiry_date"
    t.string "gender"
    t.date "birthdate"
    t.string "instagram_account"
    t.text "tags"
    t.text "notes"
    t.string "utm_source"
    t.string "utm_medium"
    t.string "utm_source_medium"
    t.string "utm_campaign"
    t.string "utm_term"
    t.string "utm_content"
    t.datetime "utm_clicked_at"
    t.string "referrer_name"
    t.string "referrer_email"
    t.string "referrer_phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_shopline_customers_on_email"
    t.index ["shopline_id"], name: "index_shopline_customers_on_shopline_id"
  end

  create_table "shopline_orders", force: :cascade do |t|
    t.string "order_number"
    t.string "product_name"
    t.string "email"
    t.string "instagram_account"
    t.string "payment_status"
    t.string "order_status"
    t.decimal "total_amount", precision: 10, scale: 2
    t.integer "quantity"
    t.string "customer_name"
    t.string "payment_method"
    t.datetime "order_date"
    t.string "utm_source"
    t.string "utm_medium"
    t.string "utm_source_medium"
    t.string "utm_campaign"
    t.string "utm_term"
    t.string "utm_content"
    t.datetime "utm_clicked_at"
    t.string "membership_level"
    t.bigint "shopline_customer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_shopline_orders_on_email"
    t.index ["shopline_customer_id"], name: "index_shopline_orders_on_shopline_customer_id"
  end

  add_foreign_key "shopline_orders", "shopline_customers"
end
