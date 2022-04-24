Rails.application.routes.draw do
  get 'shipped_items/create'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "items#index"

  resources :items
  resources :shipments, only: [:create, :show, :index, :update, :destroy]
  resources :shipped_items, only: [:create, :destroy]
end
