class User < ApplicationRecord
  has_many :orders, dependent: :nullify

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # ransack allowlist so admin filters work without exposing sensitive fields
  def self.ransackable_attributes(_ = nil)
    %w[id email created_at updated_at]
  end

  def self.ransackable_associations(_ = nil)
    %w[orders]
  end
end
