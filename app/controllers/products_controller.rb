class ProductsController < ApplicationController
  def index
    @products = Product.includes(:brand).all
  end

  def show
    @product = Product.find(params[:id])
  end
end