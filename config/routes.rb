Rails.application.routes.draw do
  
  ############################# Landing Page ####################################
  get 'welcome/index'
  root 'welcome#index'
  ###############################################################################

  ############################# Cart Routes #####################################
  get 'carts', to: 'carts#index', as: 'carts'
  delete 'remove.product/:id', to: 'carts#remove', as: 'remove_product'
  post 'add.to.cart/:id', to: 'carts#create', as: 'add_to_cart'
  put 'cart/:id', to: 'carts#update', as: 'cart'
  delete 'remove.cart/:id', to: 'carts#destroy', as: 'remove_cart'
  ###############################################################################

  ############################# Order Routes ####################################
  get 'orders', to: 'orders#index', as: 'orders'
  get 'order/:id/edit', to: 'orders#edit', as: 'edit_order'
  put 'order/:id', to: 'orders#update', as: 'order'
  ###############################################################################

  ############################# User Routes #####################################
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
    devise_scope :user do
      get '/users/sign_out' => 'devise/sessions#destroy'
  end
  ###############################################################################

  ############################# Product Routes ##################################
  # put "rate.product/:id" => 'products#rate', as: 'rate_product'
  get "/fetch_products" => 'products#filter_products', as: 'fetch_products'
  resources :products
  ###############################################################################

  ############################# Store_Orders Routes #############################
  get 'store.orders', to: 'store_orders#index', as: 'store_orders'
  put 'store.response/:id', to: 'store_orders#update', as: 'store_response'
  ###############################################################################

  ############################## Reviews Routes #################################
  post "rate.product/:id" => 'reviews#rate', as: 'rate_product'
  ###############################################################################

  ############################# Product API Routes ##############################
  namespace :api do
    resources :products
  end
  ###############################################################################
  # root to: "products#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
