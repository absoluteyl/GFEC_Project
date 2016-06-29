Rails.application.routes.draw do
  devise_for :users
  #Root Route
  root 'welcome#index'
  get 'about' => 'welcome#about'
  get 'contact' => 'welcome#contact'
  
  #Merchandises Routes
  resources :merchandises
  
  #Categories Routes
  resources :categories, except: [:destroy]
  
  #Users Routes
  # resources :users, except: [:new] do
  #   member do
  #     resources :locations, except: [:show]
  #   end
  # end
  # #new user route
  # get 'signup', to: 'users#new'
  
  #Sessions Routes
  # get 'login', to: 'sessions#new'
  # post 'login', to: 'sessions#create'
  # delete 'logout', to: 'sessions#destroy'
  
  #API Routes
  namespace :api do
    resources :merchandises
    # resources :users
    resources :locations, except: [:show]
    resources :categories, except: [:destroy]
  end
end
