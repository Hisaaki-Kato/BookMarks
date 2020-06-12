Rails.application.routes.draw do
  root   'microposts#index'
  get    '/about',   to: 'static_pages#about'
  get    '/contact', to: 'static_pages#contact'
  get    '/signup',  to: 'users#new'
  post   '/signup',  to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
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
