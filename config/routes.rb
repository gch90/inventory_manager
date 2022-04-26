Rails.application.routes.draw do
  get 'shipped_items/create'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "items#index"

  # Routes to create shipped items from item inventory
  resources :items do
    resources :shipped_items, only: [:new]
  end

  # Route for shipments CRUD
  resources :shipments, except: [:new]

  # Routes to create, delete shipped_items
  resources :shipped_items, only: %i[create destroy]
end
