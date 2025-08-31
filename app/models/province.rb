class Province < ApplicationRecord
  has_many :orders, dependent: :nullify
 def self.ransackable_attributes(_auth_object = nil)
  %w[id name code gst pst hst gst_rate pst_rate hst_rate created_at updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[orders]
  end
end
