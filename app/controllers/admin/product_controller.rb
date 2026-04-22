module Admin
  class ProductsController < ApplicationController
    before_action :authenticate_user!
    before_action :require_admin
    before_action :set_product, only: [:edit, :update, :destroy]

    def index
      @products = Product.all
    end

    def new
      @product = Product.new
    end

    def create
      @product = Product.new(product_params)

      if @product.save
        redirect_to admin_products_path, notice: "Product created"
      else
        render :new
      end
    end

    def edit
    end

    def update
      if @product.update(product_params)
        redirect_to admin_products_path, notice: "Product updated"
      else
        render :edit
      end
    end

    def destroy
      @product.destroy
      redirect_to admin_products_path, notice: "Product deleted"
    end

    private

    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(
        :name, :description, :price,
        :brand_id, :layout_id, :switch_type_id
      )
    end

    def require_admin
      unless current_user&.admin?
        redirect_to root_path, alert: "Not authorized"
      end
    end
  end
end