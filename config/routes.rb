Rails.application.routes.draw do
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:show, :create, :edit, :update]
  
  resources :requests, only: [:index, :show, :new, :create, :destroy]
  
  resources :applies, only: [:index, :create, :destroy]
  resources :works, only: [:index, :show, :edit, :new, :create] do
    member do
      get :content
      get :report
      get :confirm
      get :done
      get :finish
    end
  end
  
  resources :talks, only: [:index, :show, :create, :update, :destroy]
  
  resources :client_evaluations, only: [:index, :show, :create]
  resources :worker_evaluations, only: [:index, :show, :create]
  
  resources :articles, only:[:create]
end
