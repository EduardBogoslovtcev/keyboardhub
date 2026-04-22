class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def stripe
    payload = request.body.read
    event = nil

    begin
      event = Stripe::Event.construct_from(JSON.parse(payload, symbolize_names: true))
    rescue JSON::ParserError
      return head :bad_request
    end

    case event.type
    when "checkout.session.completed"
      handle_checkout_session(event.data.object)
    end

    head :ok
  end

  private

  def handle_checkout_session(session)
    user = User.find(session.metadata.user_id)

    cart = JSON.parse(session.metadata.cart)

    products = Product.find(cart.keys)

    subtotal = products.sum { |p| p.price * cart[p.id.to_s] }
    tax_rate = user.province&.tax_rate || 0
    total = subtotal + (subtotal * tax_rate)

    order = Order.create!(
      user: user,
      total: total,
      status: "paid"
    )

    products.each do |p|
      OrderItem.create!(
        order: order,
        product: p,
        quantity: cart[p.id.to_s],
        price: p.price
      )
    end
  end
end