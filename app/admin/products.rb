ActiveAdmin.register Product do
  permit_params :title, :description, :price_cents, :on_sale, :sale_price_cents,
                category_ids: [], images: []

  filter :title
  filter :categories
  filter :on_sale
  filter :created_at
  filter :updated_at

  index do
    selectable_column
    id_column
    column :title
    column :on_sale
    column :price_cents
    column :sale_price_cents
    column :categories do |p|
      p.categories.pluck(:name).join(", ")
    end
    actions
  end

 form do |f|
    f.inputs "Details" do
      f.input :title
      f.input :description
      f.input :on_sale
      f.input :price_cents, label: "Price (cents)"
      f.input :sale_price_cents, label: "Sale price (cents)"
      f.input :categories, as: :check_boxes, collection: Category.order(:name)
      f.input :images, as: :file, input_html: { multiple: true }
    end
    f.actions
  end
  show do
    attributes_table do
      row :id
      row :title
      row :description
      row(:price) { |p| number_to_currency(p.price) }
      row :on_sale
      row :categories do |p|
        p.categories.pluck(:name).join(", ")
      end
      row :created_at
      row :updated_at
    end

    panel "Images" do
      if resource.images.attached?
        ul do
          resource.images.each do |img|
            li { image_tag url_for(img), style: "max-width: 200px;" }
          end
        end
      else
        span "No images uploaded."
      end
    end
  end
end
