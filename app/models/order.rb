class Order < ApplicationRecord
  belongs_to :province
  belongs_to :user, optional: true

  # Ransack 4.x allowlists
  def self.ransackable_attributes(_auth_object = nil)
    %w[
      id user_id province_id status
      subtotal_cents taxes_cents total_cents
      gst_rate pst_rate hst_rate
      placed_at created_at updated_at
      first_name last_name address1 address2 city postal_code country
      stripe_payment_id
    ]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[province user]
  end
end
