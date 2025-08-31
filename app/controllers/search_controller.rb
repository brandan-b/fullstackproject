class SearchController < ApplicationController
  def index
    # comments: keyword search scoped optionally by category
    @categories = Category.order(:name)
    scope = Product.all
    if params[:category].present? && params[:category] != "all"
      scope = scope.joins(:categories).where(categories: { slug: params[:category] })
    end
    if params[:q].present?
      q = "%#{params[:q].to_s.strip.downcase}%"
      scope = scope.where("lower(products.title) LIKE ? OR lower(products.description) LIKE ?", q, q)
    end
    @products = scope.order(created_at: :desc).page(params[:page]).per(12)
    render "products/index"
  end
end
