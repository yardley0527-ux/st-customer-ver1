class AddMoreFieldsToShoplineCustomerHealthQuestionnaires < ActiveRecord::Migration[7.1]
  def change
    add_column :shopline_customer_health_questionnaires, :purchase_reason, :text
    add_column :shopline_customer_health_questionnaires, :currently_weight_loss, :boolean
    add_column :shopline_customer_health_questionnaires, :diet_type_other, :string
  end
end
