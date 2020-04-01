Rails.application.routes.draw do
  devise_for :users
  resources :users
  resources :books
  root 'home#top'
  get 'home/about', to: 'home#about'
end
