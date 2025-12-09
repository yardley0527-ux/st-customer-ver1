class CreateShoplineCustomerHealthAssessments < ActiveRecord::Migration[7.1]
  def change
    create_table :shopline_customer_health_assessments do |t|
      t.references :shopline_customer, null: false, foreign_key: true
      t.string :interaction_level
      t.text :main_health_goal
      t.text :summary_notes

      t.timestamps
    end
  end
end
