
module Admin
  class ProductsController < ApplicationController
    before_action :set_product, only: [:edit, :update, :destroy]
    before_action :require_admin
    before_action :authenticate_user!

    def index
      @products = Product.all
    end

    def new
      @product = Product.new
    end

    def create
      @product = Product.new(product_params)

      if @product.save
        redirect_to admin_products_path
      else
        render :new
      end
    end

    def edit
    end

    def update
      if @product.update(product_params)
        redirect_to admin_products_path
      else
        render :edit
      end
    end

    def destroy
      @product.destroy
      redirect_to admin_products_path
    end

    private

    def set_product
      @product = Product.find(params[:id])
    end

    def require_admin
      unless current_user&.admin?
        redirect_to root_path, alert: "Not authorized"
      end
    end

    def product_params
      params.require(:product).permit(
        :name, :description, :price, :image,
        :brand_id, :layout_id, :switch_type_id
      )
    end
  end
end