Rails.application.routes.draw do
  
  get 'home/about', as: 'home_about'
  root 'home#index'
  devise_for :users
  resources :users
  resources :books
end
