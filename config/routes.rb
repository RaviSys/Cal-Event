Rails.application.routes.draw do
  resources :events
  root 'home#index'
  devise_for :users, controllers: { 
    :omniauth_callbacks => "users/omniauth_callbacks" 
  }
end
