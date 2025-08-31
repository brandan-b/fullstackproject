class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.integer :price_cents
      t.boolean :on_sale
      t.integer :sale_price_cents

      t.timestamps
    end
  end
end
