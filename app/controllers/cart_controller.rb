class CartController < ApplicationController
  def index
    session[:cart] ||= {}
    @cart = session[:cart]
    @products = Product.find(@cart.keys)
  end

  def add
    session[:cart] ||= {}
    session[:cart] = session[:cart].to_h   # forces hash if it got corrupted

    product_id = params[:product_id].to_s

    current_qty = session[:cart][product_id].to_i
    session[:cart][product_id] = current_qty + 1

    redirect_to cart_path
  end

  def remove
    session[:cart] ||= {}

    session[:cart].delete(params[:id].to_s)

    redirect_to cart_path
  end

  def increase
    session[:cart] ||= {}

    id = params[:id].to_s
    session[:cart][id] = session[:cart][id].to_i + 1

    redirect_to cart_path
  end

  def decrease
    session[:cart] ||= {}

    id = params[:id].to_s

    if session[:cart][id].to_i > 1
      session[:cart][id] = session[:cart][id].to_i - 1
    else
      session[:cart].delete(id)
    end

    redirect_to cart_path
  end
end