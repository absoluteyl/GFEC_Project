Rails.application.routes.draw do
  
  #Root Route
  root 'welcome#index'
  get 'about' => 'welcome#about'
  get 'contact' => 'welcome#contact'
  
  #Merchandises Routes
  resources :merchandises do 
    collection do 
      get 'update_subcategories' => 'merchandises#update_subcategories', as: 'update_subcategories'
    end
    member do 
      get 'update_subcategories' => 'merchandises#update_subcategories', as: 'update_subcategories'
    end
  end
  
  #Categories Routes
  resources :categories, except: [:destroy]
  
  #Trade Routes
  resources :carts, only: [:show, :destroy]
  resources :line_items, only: [:create, :destroy]
  resources :orders, only: [:show, :new, :create] do
   get :checkout
  end
  resources :payments
  
  #Users Routes
  devise_for :users, :controllers => { :registrations => 'users/registrations' }

  resources :users, only: [:show] do
    member do
      resources :locations, except: [:show] do
        collection do
          get 'update_districts' => 'locations#update_districts', as: 'update_districts'
        end
        member do
          get 'update_districts' => 'locations#update_districts', as: 'update_districts'
        end
      end
    end
  end
  
  #API Routes
  namespace :api do
    resources :merchandises, only: [:index, :show, :create, :update, :destroy]
    resources :users
    post 'login', to: 'sessions#create'
    delete 'logout', to: 'sessions#destroy'
    resources :locations, only: [:index, :create, :update, :destroy]
    resources :categories, only: [:index]
    resources :cities, only: [:index]
  end
end
