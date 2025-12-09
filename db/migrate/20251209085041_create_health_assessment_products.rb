class CreateHealthAssessmentProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :health_assessment_products do |t|
      t.references :shopline_customer_health_assessment, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
