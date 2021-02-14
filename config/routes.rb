Rails.application.routes.draw do
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:show, :create, :edit, :update]
  
  resources :requests, only: [:index, :show, :new, :create, :destroy]
  
  resources :applies, only: [:create, :destroy]
  resources :works, only: [:index, :show, :edit, :new, :create] do
    member do
      get :report
      get :confirm
      get :done
    end
  end
  
  resources :talks, only: [:create, :update, :destroy]
  
  resources :client_evaluations, only: [:index, :show, :create]
  resources :worker_evaluations, only: [:index, :show, :create]
end
