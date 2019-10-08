Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  # Routes that operate on the book collection
  
  # Set the homepage route
  root 'books#index'
  
  resources :books #, except: [:index]
  
  get 'authors/:id', to: 'authors#show', as: 'author'
end
