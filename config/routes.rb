# frozen_string_literal: true

Rails.application.routes.draw do
  root   'microposts#index'
  get    '/about',   to: 'static_pages#about'
  get    '/contact', to: 'static_pages#contact'
  get    '/signup',  to: 'users#new'
  post   '/signup',  to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  post   '/tester',  to: 'sessions#test_create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources  :books,         only: %i[show new create destroy] do
    resource :reads,         only: %i[create destroy]
  end
  resources  :microposts,    only: %i[show create destroy] do
    resource :likes,         only: %i[create destroy]
    resource :comments,      only: %i[create destroy]
  end
  resources  :boards,        only: %i[create edit update destroy]
  resources  :relationships, only: %i[create destroy]
end
