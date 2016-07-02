Rails.application.routes.draw do
  
  get 'cart/index'

  #Root Route
  root 'welcome#index'
  get 'about' => 'welcome#about'
  get 'contact' => 'welcome#contact'
  
  #Merchandises Routes
  resources :merchandises
  
  #Categories Routes
  resources :categories, except: [:destroy]
  
  #Cart Routes
  resource :cart, only: :show
  
  #Users Routes
  devise_for :users, :controllers => { :registrations => 'users/registrations' }

  resources :users, only: [:show] do
    member do
      resources :locations, except: [:show]
    end
  end
  # #new user route
  # get 'signup', to: 'users#new'
  
  #Sessions Routes
  # get 'login', to: 'sessions#new'
  # post 'login', to: 'sessions#create'
  # delete 'logout', to: 'sessions#destroy'
  
  #API Routes
  namespace :api do
    resources :merchandises, only: [:index, :show, :create, :update, :destroy]
    resources :users
    post 'login', to: 'sessions#create'
    delete 'logout', to: 'sessions#destroy'
    resources :locations, only: [:index, :create, :update, :destroy]
    resources :categories, only: [:index]
  end
end
