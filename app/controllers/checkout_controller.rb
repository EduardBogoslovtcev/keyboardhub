class CheckoutController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_address_complete

  def ensure_address_complete
    unless current_user.address_complete?
      redirect_to edit_account_path, alert: "Please complete your address before checkout"
    end
  end

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