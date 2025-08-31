class AddMissingCheckoutFieldsToOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :first_name, :string unless column_exists?(:orders, :first_name)
    add_column :orders, :last_name, :string  unless column_exists?(:orders, :last_name)
    add_column :orders, :address1, :string   unless column_exists?(:orders, :address1)
    add_column :orders, :address2, :string   unless column_exists?(:orders, :address2)
    add_column :orders, :city, :string       unless column_exists?(:orders, :city)
    add_column :orders, :postal_code, :string unless column_exists?(:orders, :postal_code)
    add_column :orders, :country, :string    unless column_exists?(:orders, :country)
 add_reference :orders, :province, foreign_key: true unless column_exists?(:orders, :province_id)
    add_column :orders, :subtotal_cents, :integer unless column_exists?(:orders, :subtotal_cents)
    add_column :orders, :total_cents, :integer    unless column_exists?(:orders, :total_cents)
    add_column :orders, :status, :string          unless column_exists?(:orders, :status)
  end
end
