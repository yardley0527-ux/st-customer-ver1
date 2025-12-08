class CreateShoplineOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :shopline_orders do |t|
      t.string :order_number
      t.string :product_name
      t.string :email
      t.string :instagram_account
      t.string :payment_status
      t.string :order_status
      t.decimal :total_amount, precision: 10, scale: 2
      t.integer :quantity
      t.string :customer_name
      t.string :payment_method
      t.datetime :order_date
      t.string :utm_source
      t.string :utm_medium
      t.string :utm_source_medium
      t.string :utm_campaign
      t.string :utm_term
      t.string :utm_content
      t.datetime :utm_clicked_at
      t.string :membership_level
      t.references :shopline_customer, null: false, foreign_key: true

      t.timestamps
    end
    add_index :shopline_orders, :email
  end
end
