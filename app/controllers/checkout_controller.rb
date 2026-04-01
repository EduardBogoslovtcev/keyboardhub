class CheckoutController < ApplicationController
  before_action :authenticate_user!

  def index
    @cart = session[:cart] || {}
    @products = Product.find(@cart.keys)
  end

  def create
    @cart = session[:cart] || {}
    products = Product.find(@cart.keys)

    subtotal = products.sum do |p|
      p.price * @cart[p.id.to_s]
    end

    tax_rate = current_user.province&.tax_rate || 0
    total = subtotal + (subtotal * tax_rate)

    order = Order.create!(
      user: current_user,
      total: total,
      status: "paid"
    )

    products.each do |product|
      OrderItem.create!(
        order: order,
        product: product,
        quantity: @cart[product.id.to_s],
        price: product.price
      )
    end

    session[:cart] = {}

    redirect_to order_path(order)
  end
end