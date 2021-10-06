Rails.application.routes.draw do
  root 'home#index'
  devise_for :users

  get 'sales/show_total', to: 'sales#show_total', as: 'show_total'
  get 'inventories/show_chart', to: 'inventories#show_chart', as: 'chart'
  post 'inventories/update_stock/:id', to: 'inventories#update_stock', as: 'update_stock'
  post 'inventories/update_parent_stock/:id', to: 'inventories#update_parent_stock', as: 'update_parent'

  resources :products
  resources :inventories
  resources :sales, only: [:new, :index, :create, :show, :update, :destroy]
  resources :orders, only: [:edit, :update]

  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end