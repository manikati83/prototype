Rails.application.routes.draw do
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:show, :create]
  
  resources :requests, only: [:index, :show, :new, :create, :destroy]
  
  resources :applies, only: [:create, :destroy]
  resources :works, only: [:index, :show, :new, :create]
  resources :talks, only: [:create, :destroy]
end
