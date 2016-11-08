Rails.application.routes.draw do
  root 'flights#home'
  resources :flights, only: [:index]
  resources :bookings, except: [:index] do
    collection do
      get 'manage'
      get 'find'
    end
  end
  resources :users, only: [:create] do
    member do
      get 'bookings'
    end
  end
  get 'signup' => 'users#new'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
end
