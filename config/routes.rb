Rails.application.routes.draw do
  root "flights#home"

  resources :flights, only: [:index]
  resources :bookings, except: [:index] do
    collection do
      get "manage"
    end
  end

  get 'signup'=> 'users#new'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  resources :users
end
