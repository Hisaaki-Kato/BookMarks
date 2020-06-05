Rails.application.routes.draw do
  root   'microposts#index'
  get    '/signup',  to: 'users#new'
  post   '/signup',  to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get    '/books',   to: 'books#index'
  resources  :users do
    member do
      get    :following, :followers
    end
  end
  resources  :books,         only: [:show, :new, :create, :destroy] do
    resource :reads,         only: [:create, :destroy]
  end
  resources  :microposts,    only: [:show, :create, :destroy] do
    resource :likes,         only: [:create, :destroy]
    resource :comments,      only: [:create, :destroy]
  end
  resources  :boards,        only: [:create, :edit, :update, :destroy]
  resources  :relationships, only: [:create, :destroy]
end
