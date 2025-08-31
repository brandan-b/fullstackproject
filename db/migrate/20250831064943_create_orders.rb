class CreateOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.references :province, null: false, foreign_key: true
      t.integer :subtotal_cents
      t.decimal :gst_rate, precision: 5, scale: 4
      t.decimal :pst_rate, precision: 5, scale: 4
      t.decimal :hst_rate, precision: 5, scale: 4
      t.integer :taxes_cents
      t.integer :total_cents
      t.integer :status
      t.string :stripe_payment_id
      t.datetime :placed_at
      t.text :shipping_address_json

      t.timestamps
    end
  end
end
