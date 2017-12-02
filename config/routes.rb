Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # we want to see multiple products
  resources :products do
    resources :order_items
  end
  
  # we want our users to order multiple times
  resources :orders
  
  # we only want a user to see ONE cart
  resource :cart
  
  get "info", to: "pages#info"
  
  root "pages#home"

end
