Rails.application.routes.draw do
  devise_for :users

  root "products#index"

  # Products
  resources :products, only: [:index, :show]

  # Cart
  get "/cart", to: "cart#index"
  post "/cart/add", to: "cart#add", as: :cart_add
  delete "/cart/remove/:id", to: "cart#remove", as: :cart_remove

  # Checkout
  get "/checkout", to: "checkout#index"
  post "/checkout/create", to: "checkout#create"

  # Orders
  resources :orders, only: [:index, :show]

  # Account
  get "/account", to: "account#show"

  # Admin
  namespace :admin do
    resources :products
  end
end