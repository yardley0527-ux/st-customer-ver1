class CreateShoplineCustomerHealthQuestionnaires < ActiveRecord::Migration[7.1]
  def change
    create_table :shopline_customer_health_questionnaires do |t|
      t.references :shopline_customer, null: false, foreign_key: true
      t.integer :height_cm
      t.decimal :weight_kg, precision: 5, scale: 1
      t.integer :body_fat_percentage
      t.string :work_type
      t.date :birthdate
      t.string :marital_status
      t.integer :family_members_count
      t.text :family_members_details
      t.string :sleep_time
      t.string :wake_time
      t.integer :water_intake_ml
      t.string :diet_type, array: true, default: []
      t.boolean :take_chinese_medicine
      t.boolean :bought_our_products
      t.boolean :bought_other_supplements
      t.text :previous_weight_loss_methods

      t.timestamps
    end
  end
end
