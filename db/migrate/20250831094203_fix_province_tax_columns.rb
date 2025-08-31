class FixProvinceTaxColumns < ActiveRecord::Migration[7.1]
  def change
if column_exists?(:provinces, :gst_change) && !column_exists?(:provinces, :gst_rate)
      rename_column :provinces, :gst_change, :gst_rate
    end

    add_column :provinces, :gst_rate, :decimal, precision: 5, scale: 4, default: 0, null: false unless column_exists?(:provinces, :gst_rate)
    add_column :provinces, :pst_rate, :decimal, precision: 5, scale: 4, default: 0, null: false unless column_exists?(:provinces, :pst_rate)
    add_column :provinces, :hst_rate, :decimal, precision: 5, scale: 4, default: 0, null: false unless column_exists?(:provinces, :hst_rate)
  end
end
