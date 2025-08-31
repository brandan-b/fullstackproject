class AddUniqueIndexToCategorizations < ActiveRecord::Migration[7.1]
  def change
    add_index :categorizations, [:product_id, :category_id],
              unique: true,
              name: 'idx_categorizations_product_category' unless
      index_exists?(:categorizations, [:product_id, :category_id],
                    unique: true, name: 'idx_categorizations_product_category')
  end
end
