Rails.application.routes.draw do
  root 'home#index'
  devise_for :users

  get 'inventories/show_chart', to: 'inventories#show_chart', as: 'chart'
  get 'home/show_record/:id', to: 'home#show_record', as: 'show_record'
  get 'home/show_sale', to: 'home#show_sale', as: 'show_sale'
  get 'sales/delete_request/:id', to: 'sales#delete_request', as: 'delete_request'

  resources :products
  resources :inventories
  resources :sales, only: [:new, :index, :create, :show, :update, :destroy]
  resources :orders, only: [:edit, :update]
  resources :home, only: [:show]
  resources :records, only: [:index, :show]

  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end