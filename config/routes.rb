Rails.application.routes.draw do
  root "flights#home"

  resources :flights, only: [:index]
  resources :bookings, except: [:index] do
    collection do
      get "manage"
    end
  end
end
