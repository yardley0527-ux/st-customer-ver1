class CreateShoplineCustomers < ActiveRecord::Migration[7.1]
  def change
    create_table :shopline_customers do |t|
      t.string :shopline_id
      t.string :full_name
      t.string :email
      t.datetime :joined_at
      t.string :join_source
      t.string :language
      t.integer :order_count
      t.decimal :total_amount, precision: 10, scale: 2
      t.decimal :issued_shopping_credits, precision: 10, scale: 2
      t.decimal :deducted_shopping_credits, precision: 10, scale: 2
      t.decimal :used_shopping_credits, precision: 10, scale: 2
      t.decimal :current_shopping_credits, precision: 10, scale: 2
      t.integer :issued_points
      t.integer :deducted_points
      t.integer :used_points
      t.integer :current_points
      t.boolean :is_member
      t.datetime :member_registered_at
      t.string :member_registration_source
      t.string :facebook_id
      t.string :line_id
      t.boolean :blacklisted
      t.boolean :has_password
      t.boolean :accept_email_marketing
      t.boolean :accept_sms_marketing
      t.boolean :accept_fb_marketing
      t.boolean :accept_line_marketing
      t.boolean :accept_whatsapp_marketing
      t.datetime :last_login_at
      t.string :phone
      t.string :country_code
      t.string :mobile_phone
      t.string :recipient_name
      t.string :recipient_phone
      t.string :address_1
      t.string :address_2
      t.string :city
      t.string :state
      t.string :postal_code
      t.string :country
      t.string :membership_level
      t.date :membership_expiry_date
      t.string :gender
      t.date :birthdate
      t.string :instagram_account
      t.text :tags
      t.text :notes
      t.string :utm_source
      t.string :utm_medium
      t.string :utm_source_medium
      t.string :utm_campaign
      t.string :utm_term
      t.string :utm_content
      t.datetime :utm_clicked_at
      t.string :referrer_name
      t.string :referrer_email
      t.string :referrer_phone

      t.timestamps
    end
    add_index :shopline_customers, :shopline_id
    add_index :shopline_customers, :email
  end
end
