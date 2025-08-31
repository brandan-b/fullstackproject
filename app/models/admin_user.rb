class AdminUser < ApplicationRecord
  # ransack allowlist to avoid exposing sensitive fields
  def self.ransackable_attributes(auth_object = nil)
    %w[email id created_at updated_at]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
  # ransack allowlist to avoid exposing sensitive fields
  def self.ransackable_attributes(auth_object = nil)
    %w[email id created_at updated_at]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :validatable
end
