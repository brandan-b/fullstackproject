class ProductsController < ApplicationController
  def index
    scope = Product.order(created_at: :desc)

    case params[:filter]
    when 'on_sale'
      scope = scope.where(on_sale: true)
    when 'new'
      scope = scope.where('created_at >= ?', 3.days.ago)
    when 'recently_updated'
      scope = scope.where('updated_at >= ?', 3.days.ago)
                   .where('created_at < ?', 3.days.ago) # exclude brand new
    end

    @products = scope.page(params[:page]).per(12)
  end

  def show
    @product = Product.find(params[:id])
  end
end
