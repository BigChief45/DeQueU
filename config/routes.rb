Rails.application.routes.draw do
  
    devise_for :users
  
    devise_scope :user do
        get 'registro', to: 'devise/registrations#new'
        get 'login', to: 'devise/sessions#new'
        delete 'logout', to: 'devise/sessions#destroy'
    end
  
    get 'qp2', to: 'stories#index'
    get 'my_stories', to: 'stories#my_stories'
    get 'admin', to: 'admin#index'
    
    resources :stories do
       member do
           put 'like', to: 'stories#upvote'
       end
       resources :comments, only: [:create]
    end
    
    resources :categories
    resources :users, only: [:show] do
       get 'users/:username' => 'users#show'
    end
    
    resources :favorite_stories, only: [:index, :create, :destroy]
  
    resources :admins, only: [:index]
  
    root 'home#index'
end
