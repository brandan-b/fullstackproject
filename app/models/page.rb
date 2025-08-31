class Page < ApplicationRecord
  # ransack allowlist for admin search
  def self.ransackable_attributes(_ = nil)
    %w[id slug title content created_at updated_at]
  end
  def self.ransackable_associations(_ = nil)
    []
  end
end
