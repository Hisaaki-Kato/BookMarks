Rails.application.routes.draw do
  root 'users#home' #test -> microposts list
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  resources :users
end
