class CartController < ApplicationController
  def index
    @cart = session[:cart] || {}
    @products = Product.find(@cart.keys)
  end

  def add
    session[:cart] ||= {}

    product_id = params[:product_id].to_s

    if session[:cart][product_id]
      session[:cart][product_id] += 1
    else
      session[:cart][product_id] = 1
    end

    redirect_to cart_path
  end

  def remove
    session[:cart].delete(params[:id])
    redirect_to cart_path
  end
end