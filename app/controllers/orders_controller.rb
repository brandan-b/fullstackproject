class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_provinces, only: [:new, :create]

  def index
    @orders = current_user.orders.order(created_at: :desc)
  end

  def show
    @order  = current_user.orders.find(params[:id])
    @items  = @order.order_items.includes(:product)
    @ship   = JSON.parse(@order.shipping_address_json || "{}")
  end
def new
    build_cart_summary
    @order = current_user.orders.new
    if @subtotal_cents.zero?
      redirect_to cart_path, alert: "Your cart is empty." and return
    end
  end

  def create
    build_cart_summary
    if @subtotal_cents.zero?
      redirect_to cart_path, alert: "Your cart is empty." and return
    end
 province = Province.find_by(id: order_params[:province_id])
    gst = province&.gst_rate.to_f
    pst = province&.pst_rate.to_f
    hst = province&.hst_rate.to_f

    taxes_cents = (@subtotal_cents * (gst + pst + hst)).round
    total_cents = @subtotal_cents + taxes_cents

    shipping_hash = {
      first_name:  order_params[:first_name],
      last_name:   order_params[:last_name],
      address1:    order_params[:address1],
      address2:    order_params[:address2],
      city:        order_params[:city],
      postal_code: order_params[:postal_code],
      country:     order_params[:country],
      province_id: order_params[:province_id]
    }.compact

    @order = current_user.orders.new(
      province_id:         province&.id,
      subtotal_cents:      @subtotal_cents,
      taxes_cents:         taxes_cents,
      total_cents:         total_cents,
      gst_rate:            gst,
      pst_rate:            pst,
      hst_rate:            hst,
      status:              "pending",
      placed_at:           Time.current,
      shipping_address_json: shipping_hash.to_json
    )

    Order.transaction do
      @order.save!

      @cart_items.each do |ci|
        @order.order_items.create!(
          product:          ci[:product],
          quantity:         ci[:quantity],
          unit_price_cents: ci[:unit_cents],
          line_cents:       ci[:line_cents]
        )
      end
    end


  session[:cart] = {}
    redirect_to order_path(@order), notice: "Order placed! ##{@order.id}"
  rescue ActiveRecord::RecordInvalid => e
    flash.now[:alert] = "Could not place order: #{e.record.errors.full_messages.to_sentence}"
    render :new, status: :unprocessable_entity
  end

  private

  def set_provinces
    @provinces = Province.order(:name)
  end

  def order_params
    params.require(:order).permit(:first_name, :last_name, :address1, :address2, :city, :postal_code, :province_id, :country)
  end
  def build_cart_summary
    raw = (session[:cart] || {}).dup
    @cart_items = []
    @subtotal_cents = 0

    raw.each do |pid, qty|
      product = Product.find_by(id: pid)
      next unless product
      q = qty.to_i
      next if q <= 0

      unit_cents = product.price_cents.to_i
      line_cents = unit_cents * q
      @subtotal_cents += line_cents


      @cart_items << {
        product:    product,
        quantity:   q,
        unit_cents: unit_cents,
        line_cents: line_cents
      }
    end
  end
end
