# app/models/shopline_customer.rb
class ShoplineCustomer < ApplicationRecord
  has_many :shopline_orders
  validates :shopline_id, presence: true, uniqueness: true
  validates :email, uniqueness: true, allow_blank: true

  scope :members, -> { where(is_member: true) }
  scope :non_members, -> { where(is_member: false) }
  scope :blacklisted, -> { where(blacklisted: true) }
  scope :email_subscribers, -> { where(accept_email_marketing: true) }
  scope :sms_subscribers, -> { where(accept_sms_marketing: true) }

  def full_address
      [address_1, address_2, city, state, postal_code, country].compact.join(', ')
  end

  def has_orders?
      order_count.to_i > 0
  end

  def has_complete_profile?
      email.present? && mobile_phone.present? && birthdate.present?
  end

  def membership_active?
      is_member && (membership_expiry_date.nil? || membership_expiry_date >= Date.today)
  end
end