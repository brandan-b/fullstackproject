class EnsureOrderItemsStructure < ActiveRecord::Migration[7.1]
  def change
    create_table :order_items, if_not_exists: true do |t|
      t.references :order, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.integer :quantity, null: false, default: 1
      t.integer :unit_price_cents, null: false, default: 0
      t.integer :line_cents, null: false, default: 0
      t.timestamps
    end

  add_reference :order_items, :order,   foreign_key: true unless column_exists?(:order_items, :order_id)
    add_reference :order_items, :product, foreign_key: true unless column_exists?(:order_items, :product_id)
    add_column :order_items, :quantity,          :integer, null: false, default: 1 unless column_exists?(:order_items, :quantity)
    add_column :order_items, :unit_price_cents,  :integer, null: false, default: 0 unless column_exists?(:order_items, :unit_price_cents)
    add_column :order_items, :line_cents,        :integer, null: false, default: 0 unless column_exists?(:order_items, :line_cents)
  end
end
