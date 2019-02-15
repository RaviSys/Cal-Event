Rails.application.routes.draw do
  resources :events do 
    collection do 
      get :event_calendar
      get :events_for_calendar
    end
  end
  root 'home#index'
  devise_for :users, controllers: { 
    :omniauth_callbacks => "users/omniauth_callbacks" 
  }
end
