Rails.application.routes.draw do

  get '/login' => 'session#new'
  post '/login' => 'session#create'
  delete '/login' => 'session#destroy'

  get '/cart' => 'carts#user_cart'

  resources :users, except: [:index]
  resources :products, only: [:index, :show]
  resources :carts, only: [:create, :destroy]
  resources :line_items, only: [:create, :update, :destroy]

  resources :orders, only: [:create, :show]

  get '/order/confirm_order' => 'orders#confirm_order', as: 'confirm_order'
  post '/order/initiate_payment' => 'orders#initiate_payment', as: 'initiate_payment'
  get '/order/complete_order' => 'orders#complete_order', as: 'complete_order'
end
