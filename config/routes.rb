Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  # Routes that operate on the book collection
  
  # Set the homepage route
  root 'books#index'
  
  resources :books #, except: [:index]
  
  get 'authors/:id', to: 'authors#show', as: 'author'
  
  # get "/login", to: "users#login_form", as: "login"
  # post "/login", to: "users#login"
  # post "/logout", to: "users#logout", as: "logout"
  get "/users/current", to: "users#current", as: "current_user"
  
  get "/auth/github", as: "github_login"
  get "/auth/:provider/callback", to: "users#create", as: "auth_callback"
  delete "/logout", to: "users#destroy", as: "logout"
end
