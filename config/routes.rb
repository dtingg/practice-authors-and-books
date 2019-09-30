Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # verb 'path', to: 'controller#action'
  get '/books', to: 'books#index'
  get '/books/:id', to: 'books#show'
  
end
