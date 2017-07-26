Rails.application.routes.draw do

  #Post
  resources :posts

  #User
  get '/users', to: 'users#index'
  post '/users', to: 'users#create'
  get '/users/new', to: 'users#new', as: :new_user
  get '/users/:id/edit', to: 'users#edit', as: :edit_user
  get '/users/:id', to: 'users#show', as: :user
  patch '/users/:id', to: 'users#update'
  delete 'users/:id', to: 'users#destroy'

  #Root
  root 'posts#index'
end
