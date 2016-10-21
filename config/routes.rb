Rails.application.routes.draw do

  root 'flights#home'

  resources :flights, only: [:index]
  resources :bookings, only: [:new, :create, :show, :edit, :update, :destroy] do
    collection do
      get "manage"
    end
  end
end
