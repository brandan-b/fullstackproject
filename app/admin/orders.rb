ActiveAdmin.register Order do
  permit_params :user_id, :province_id, :status, :stripe_payment_id, :placed_at

  # Keep filters to safe, real columns/associations only
  filter :id
  filter :status
  filter :user,  collection: -> { User.order(:email).map { |u| [u.email, u.id] } }
  filter :province
  filter :created_at

  # Avoid problematic/virtual fields (rates/monetized internals/AS)
  config.clear_sidebar_sections!  # clear anything auto-added first
end
