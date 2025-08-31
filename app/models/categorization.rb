class Categorization < ApplicationRecord
  belongs_to :product
  belongs_to :category

  # Ransack 4.x allowlists
  def self.ransackable_attributes(_auth_object = nil)
    %w[id product_id category_id created_at updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[product category]
  end
end
