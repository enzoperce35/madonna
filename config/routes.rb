Rails.application.routes.draw do
  root 'home#index'
  devise_for :users

  get 'sales/show_total', to: 'sales#show_total', as: 'show_total'
  post 'inventories/update_stock/:id', to: 'inventories#update_stock', as: 'update_stock'

  resources :products
  resources :inventories
  resources :sales, only: [:new, :create, :show, :update, :destroy]
  resources :orders, only: [:edit, :update]

  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end