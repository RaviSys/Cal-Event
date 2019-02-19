Rails.application.routes.draw do
  resources :events do 
    collection do 
      get :event_calendar
      get :events_for_calendar
      post :add_quick_event
      patch :sync_all_user_events_with_google
    end
    member do 
      patch :sync_event_with_google
    end
  end
  root 'home#index'
  get 'zip' => "home#convert_to_zip"
  post 'to_zip' => "home#to_zip"
  devise_for :users, controllers: { 
    :omniauth_callbacks => "users/omniauth_callbacks" 
  }
end
