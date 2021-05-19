Rails.application.routes.draw do

  # mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  resources :orders
  get 'welcome/index'
  resources :orders
  root 'welcome#index'
  ############################# User Routes #####################################
  devise_for :users
    devise_scope :user do
      get '/users/sign_out' => 'devise/sessions#destroy'
  end
  ###############################################################################

  ############################# Product Routes ##################################
  get "/fetch_products" => 'products#filter_products', as: 'fetch_products'
  resources :products

  ###############################################################################

  ############################# Product API Routes ##############################
  namespace :api do
    resources :products
  end
  ###############################################################################
  # root to: "products#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
