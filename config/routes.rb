Rails.application.routes.draw do

  get '/login' => 'session#new'
  post '/login' => 'session#create'
  delete '/login' => 'session#destroy'

  resources :users, except: [:index]
  resources :products, only: [:index, :show]
  resources :carts, except: [:new, :index, :destroy]
  resources :line_items, only: [:create, :update, :destroy]

end
