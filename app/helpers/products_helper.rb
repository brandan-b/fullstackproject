module ProductsHelper
  def product_name(product)
    product.try(:name) ||
      product.try(:title) ||
      product.try(:product_name) ||
      product.try(:label) ||
      "Product ##{product.id}"
  end

  # Figure out a numeric price value from common fields.
  def product_price_amount(product)
    if product.respond_to?(:price) && product.price.present?
      product.price
    elsif product.respond_to?(:unit_price) && product.unit_price.present?
      product.unit_price
    elsif product.respond_to?(:amount) && product.amount.present?
      product.amount
    elsif product.respond_to?(:price_cents) && product.price_cents.present?
      BigDecimal(product.price_cents) / 100
    else
      0
    end
  end
 def product_price(product)
    number_to_currency(product_price_amount(product))
  end

  def product_description(product)
    product.try(:description).presence
  end
end
