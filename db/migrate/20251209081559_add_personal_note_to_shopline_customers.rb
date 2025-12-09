class AddPersonalNoteToShoplineCustomers < ActiveRecord::Migration[7.1]
  def change
    add_column :shopline_customers, :personal_note, :text
  end
end
