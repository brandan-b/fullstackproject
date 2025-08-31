class CreateAddresses < ActiveRecord::Migration[8.0]
  def change
    create_table :addresses do |t|
      t.references :user, null: false, foreign_key: true
      t.references :province, null: false, foreign_key: true
      t.string :line1
      t.string :line2
      t.string :city
      t.string :postal_code
      t.string :country

      t.timestamps
    end
  end
end
