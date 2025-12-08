class ShoplineOrder < ApplicationRecord
  belongs_to :shopline_customer, optional: true
  
  validates :order_number, presence: true
  validates :product_name, presence: true
  
  def assign_customer
    customer = ShoplineCustomer.find_by(email: email)
    update(shopline_customer: customer) if customer
  end
end