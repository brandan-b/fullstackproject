class CartsController < ApplicationController
  helper_method :cart_hash, :cart_items, :cart_subtotal_cents

  def show
  end
def update
    # comments: add or change quantity; expects params[:product_id], params[:quantity]
    pid = params[:product_id].to_s
    qty = params[:quantity].to_i
    h = cart_hash
    if qty <= 0
      h.delete(pid)
    else
      h[pid] = qty
    end
    session[:cart] = h
    redirect_to cart_path
  end
def destroy
    session[:cart] = {}
    redirect_to cart_path
  end

  private

  def cart_hash
    session[:cart] ||= {}
  end
def cart_items
    # comments: maps cart hash to product objects and quantities
    ids = cart_hash.keys
    products = Product.where(id: ids).index_by(&:id)
    cart_hash.map do |pid, qty|
      p = products[pid.to_i]
      next unless p
      price = p.display_price_cents
      { product: p, quantity: qty.to_i, line_cents: price * qty.to_i, unit_cents: price }
    end.compact
  end

  def cart_subtotal_cents
    cart_items.sum { |ci| ci[:line_cents] }
  end
end
