Rails.application.routes.draw do
  root :to => "home#index"
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  
  resources :activites
  resources :notifications
  resources :friendships
  # resource  :users do
    resources :groups
  # end
  resources :orders do
    resources :orderdetails
    member do
      post 'invited' 
      post 'joined'
    end
    
  end
  
  
  
  



end
