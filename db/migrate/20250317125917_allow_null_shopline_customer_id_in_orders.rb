class AllowNullShoplineCustomerIdInOrders < ActiveRecord::Migration[7.0]
  def change
    change_column_null :shopline_orders, :shopline_customer_id, true
  end
end