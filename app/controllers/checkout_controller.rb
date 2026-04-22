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
    cart = session[:cart] || {}

    products = Product.find(cart.keys)

    line_items = products.map do |p|
      quantity = cart[p.id.to_s]

      {
        price_data: {
          currency: 'cad',
          product_data: {
            name: p.name
          },
          unit_amount: (p.price * 100).to_i # cents
        },
        quantity: quantity
      }
    end

    # TAX CALCULATION
    subtotal = products.sum { |p| p.price * cart[p.id.to_s] }
    tax_rate = current_user.province&.tax_rate || 0
    tax = (subtotal * tax_rate * 100).to_i

    if tax > 0
      line_items << {
        price_data: {
          currency: 'cad',
          product_data: {
            name: "Tax"
          },
          unit_amount: tax
        },
        quantity: 1
      }
    end

    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: line_items,
      mode: 'payment',
      success_url: "#{root_url}checkout/success",
      cancel_url: "#{root_url}cart"
    )

    redirect_to session.url, allow_other_host: true
  end
end