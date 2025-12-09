class HealthAssessmentProduct < ApplicationRecord
  belongs_to :shopline_customer_health_assessment, optional: true
  belongs_to :product, optional: true
end
