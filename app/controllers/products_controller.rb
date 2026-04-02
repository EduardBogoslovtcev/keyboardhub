class ProductsController < ApplicationController
  def index
    @products = Product.includes(:brand, :layout, :switch_type)

    # Search
    if params[:search].present?
      @products = @products.where("name LIKE ?", "%#{params[:search]}%")
    end

    # Filters
    if params[:brand_id].present?
      @products = @products.where(brand_id: params[:brand_id])
    end

    if params[:layout_id].present?
      @products = @products.where(layout_id: params[:layout_id])
    end

    if params[:switch_type_id].present?
      @products = @products.where(switch_type_id: params[:switch_type_id])
    end

    # Pagination (keep LAST)
    @products = @products.page(params[:page]).per(12)

    # For dropdowns
    @brands = Brand.all
    @layouts = Layout.all
    @switch_types = SwitchType.all
  end

  def show
    @product = Product.find(params[:id])
  end
end