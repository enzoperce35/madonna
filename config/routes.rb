Rails.application.routes.draw do
  root 'home#index'
  devise_for :users

  get 'sales/orders/:id', to: 'sales#orders', as: 'orders'
  get 'sales/discard', to: 'sales#discard', as: 'discard'
  get 'sales/alter_total', to: 'sales#alter_total', as: 'alter_total'
  get 'sales/show_total', to: 'sales#show_total', as: 'show_total'

  resources :products, :ingredients, :packagings, only: [:new, :create, :show, :update, :destroy, :edit]
  resources :sales, only: [:new, :create, :show, :update, :destroy]
  resources :inventories, only: [:index]
  resources :orders, only: [:edit, :update]

  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end