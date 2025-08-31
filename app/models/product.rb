class Product < ApplicationRecord
  has_many :categorizations, dependent: :destroy
  has_many :categories, through: :categorizations
  has_many_attached :images
validates :title, presence: true, length: { minimum: 2 }
  validates :price_cents, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true

def price
    cents = if on_sale && sale_price_cents.to_i > 0
              sale_price_cents
            else
              price_cents
            end
    (cents || 0) / 100.0
  end
def self.ransackable_attributes(_auth_object = nil)
    %w[id title description price_cents on_sale sale_price_cents created_at updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[categorizations categories]
  end
end
