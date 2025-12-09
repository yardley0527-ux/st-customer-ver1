class ShoplineCustomerHealthAssessment < ApplicationRecord
  belongs_to :shopline_customer

  has_many :health_assessment_products, dependent: :destroy
  has_many :products, through: :health_assessment_products

  accepts_nested_attributes_for :health_assessment_products, allow_destroy: true
end
